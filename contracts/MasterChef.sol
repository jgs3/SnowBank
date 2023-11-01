// SPDX-License-Identifier: UNLICENSED















pragma solidity ^0.8.15;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "./ThreeWildToken.sol";

// MasterChef is the master of THREEWILD. He can make THREEWILD and he is a fair guy.
//
// Note that it's ownable and the owner wields tremendous power. The ownership
// will be transferred to a governance smart contract once THREEWILD is sufficiently
// distributed and the community can show to govern itself.
//

contract MasterChef is IERC721Receiver, Ownable, ReentrancyGuard {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    // Info of each user.
    struct UserInfo {
        uint256 amount; // How many LP tokens the user has provided.
        uint256 rewardDebt; // Reward debt. See explanation below.
        uint256 lastWithdrawTime; // We count in timestamps so uin256 is sufficient.
        uint256 lastHarvestTime;
        uint256 harvestTimes;
        uint256[] tokenIds; // NFT token IDs which the user has provided.

        //
        // We do some fancy math here. Basically, any point in time, the amount of THREEWILDs
        // entitled to a user but is pending to be distributed is:
        //
        //   pending reward = (user.amount * pool.accThreeWildPerShare) - user.rewardDebt
        //
        // Whenever a user deposits or withdraws LP tokens to a pool. Here's what happens:
        //   1. The pool's `accThreeWildPerShare` (and `lastRewardTime`) gets updated.
        //   2. User receives the pending reward sent to his/her address.
        //   3. User's `amount` gets updated.
        //   4. User's `rewardDebt` gets updated.
    }

    // Info of each pool.
    struct PoolInfo {
        address lpToken; // Address of LP token contract.
        uint256 allocPoint; // How many allocation points assigned to this pool. THREEWILDs to distribute per block.
        uint256 lastRewardTime; // Last block number that THREEWILDs distribution occurs.
        uint256 accThreeWildPerShare; // Accumulated THREEWILDs per share, times 1e18. See below.
        uint16 depositFeeBP; // Deposit fee in basis points
        bool isNFTPool; // if lastRewardTime has passed
    }

    // The THREEWILD TOKEN!
    ThreeWildToken public threeWild;
    // Dev address.
    address public devaddr;
    // THREEWILD tokens created per block.
    uint256 public threeWildPerSecond = 0;
    // total dev alloc
    uint256 public totalDevAlloc;
    // Bonus muliplier for early threeWild makers.
    uint256 public constant BONUS_MULTIPLIER = 1;
    // maximim compound per day, per user.
    uint256 public MAX_COMPOUND_PER_DAY = 3;
    // Deposit Fee address
    address public feeAddress;
    address public admin;

    // Info of each pool.
    PoolInfo[] public poolInfo;
    // Info of each user that stakes LP tokens.
    mapping(uint256 => mapping(address => UserInfo)) public userInfo;
    // Total allocation points. Must be the sum of all allocation points in all pools.
    uint256 public totalAllocPoint = 0;
    // The timestamp when THREEWILD mining starts.
    uint256 public startTime;
    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event EmergencyWithdraw(address indexed user, uint256 indexed pid, uint256 amount);
    uint256 public amountPerNFT = 1000 ether;

    modifier validatePoolByPid(uint256 _pid) {
        require(_pid < poolInfo.length, "Pool does not exist");
        _;
    }
    modifier onlyFinancialManager() {
        require(admin == _msgSender(), "You are not the admin");
        _;
    }

    constructor(address _threeWild, address _devaddr, address _feeAddress1, uint256 _startTime) {
        threeWild = ThreeWildToken(_threeWild);
        devaddr = _devaddr;
        feeAddress = _feeAddress1;
        startTime = _startTime;
        admin = msg.sender;
    }

    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata
    ) external returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    function poolLength() external view returns (uint256) {
        return poolInfo.length;
    }

    // Add a new lp to the pool. Can only be called by the owner.
    // XXX DO NOT add the same LP token more than once. Rewards will be messed up if you do.
    function add(
        uint256 _allocPoint,
        address _lpToken,
        uint16 _depositFeeBP,
        bool _withUpdate,
        bool _isNFTPool
    ) public onlyOwner {
        require(_depositFeeBP <= 1000, "add: invalid deposit fee basis points");
        if (_withUpdate) {
            massUpdatePools();
        }
        uint256 lastRewardTime = block.timestamp > startTime ? block.timestamp : startTime;
        totalAllocPoint = totalAllocPoint.add(_allocPoint);
        poolInfo.push(
            PoolInfo({
                lpToken: _lpToken,
                allocPoint: _allocPoint,
                lastRewardTime: lastRewardTime,
                accThreeWildPerShare: 0,
                depositFeeBP: _depositFeeBP,
                isNFTPool: _isNFTPool
            })
        );
    }

    // Update the given pool's THREEWILD allocation point and deposit fee. Can only be called by the owner.
    function set(
        uint256 _pid,
        uint256 _allocPoint,
        uint16 _depositFeeBP,
        uint256 _startTime,
        bool _withUpdate
    ) public onlyOwner {
        require(_depositFeeBP <= 1000, "set: invalid deposit fee basis points");
        require(_allocPoint <= 1000, "set: invalid alloc point basis points");
        if (_withUpdate) {
            massUpdatePools();
        }
        totalAllocPoint = totalAllocPoint.sub(poolInfo[_pid].allocPoint).add(_allocPoint);
        poolInfo[_pid].allocPoint = _allocPoint;
        poolInfo[_pid].depositFeeBP = _depositFeeBP;
        poolInfo[_pid].lastRewardTime = _startTime;
    }

    // Return reward multiplier over the given _from to _to block.
    function getMultiplier(uint256 _fromTime, uint256 _toTime) public view returns (uint256) {
        if (_fromTime >= _toTime) return 0;
        if (_toTime <= startTime) return 0;
        if (_fromTime <= startTime) return _toTime.sub(startTime).mul(threeWildPerSecond);
        return _toTime.sub(_fromTime).mul(threeWildPerSecond);
    }

    // View function to see pending THREEWILDs on frontend.
    function pendingThreeWild(uint256 _pid, address _user) external view returns (uint256) {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][_user];
        uint256 accThreeWildPerShare = pool.accThreeWildPerShare;
        if (pool.isNFTPool) {
            uint256 lpSupply = IERC721(pool.lpToken).balanceOf(address(this));
            if (block.timestamp > pool.lastRewardTime && lpSupply != 0) {
                uint256 multiplier = getMultiplier(pool.lastRewardTime, block.timestamp);
                uint256 threeWildReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
                accThreeWildPerShare = accThreeWildPerShare.add(
                    threeWildReward.mul(1e18).div(lpSupply.mul(amountPerNFT))
                );
            }
            return
                user.amount.mul(amountPerNFT).mul(accThreeWildPerShare).div(1e18).sub(user.rewardDebt);
        } else {
            uint256 lpSupply = IERC20(pool.lpToken).balanceOf(address(this));
            if (block.timestamp > pool.lastRewardTime && lpSupply != 0) {
                uint256 multiplier = getMultiplier(pool.lastRewardTime, block.timestamp);
                uint256 threeWildReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
                accThreeWildPerShare = accThreeWildPerShare.add(threeWildReward.mul(1e18).div(lpSupply));
            }
            return user.amount.mul(accThreeWildPerShare).div(1e18).sub(user.rewardDebt);
        }
    }

    // Update reward variables for all pools. Be careful of gas spending!
    function massUpdatePools() public {
        uint256 length = poolInfo.length;
        for (uint256 pid = 0; pid < length; ++pid) {
            updatePool(pid);
        }
    }

    // Update reward variables of the given pool to be up-to-date.
    function updatePool(uint256 _pid) public {
        PoolInfo storage pool = poolInfo[_pid];
        if (block.timestamp <= pool.lastRewardTime) {
            return;
        }
        if (pool.isNFTPool) {
            uint256 lpSupply = IERC721(pool.lpToken).balanceOf(address(this));
            if (lpSupply == 0 || pool.allocPoint == 0) {
                pool.lastRewardTime = block.timestamp;
                return;
            }
            uint256 multiplier = getMultiplier(pool.lastRewardTime, block.timestamp);
            uint256 threeWildReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
            ThreeWildToken(threeWild).mint(devaddr, threeWildReward.div(5));
            ThreeWildToken(threeWild).mint(address(this), threeWildReward);
            totalDevAlloc += threeWildReward.div(5);
            pool.accThreeWildPerShare = pool.accThreeWildPerShare.add(
                threeWildReward.mul(1e18).div(lpSupply.mul(amountPerNFT))
            );
            pool.lastRewardTime = block.timestamp;
        } else {
            uint256 lpSupply = IERC20(pool.lpToken).balanceOf(address(this));
            if (lpSupply == 0 || pool.allocPoint == 0) {
                pool.lastRewardTime = block.timestamp;
                return;
            }
            uint256 multiplier = getMultiplier(pool.lastRewardTime, block.timestamp);
            uint256 threeWildReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
            ThreeWildToken(threeWild).mint(devaddr, threeWildReward.div(5));
            ThreeWildToken(threeWild).mint(address(this), threeWildReward);
            totalDevAlloc += threeWildReward.div(5);
            pool.accThreeWildPerShare = pool.accThreeWildPerShare.add(threeWildReward.mul(1e18).div(lpSupply));
            pool.lastRewardTime = block.timestamp;
        }
    }

    // Deposit LP tokens to MasterChef for THREEWILD allocation.
    function deposit(uint256 _pid, uint256 _amount) public nonReentrant {
        _deposit(_pid, _amount);
    }

    /// @notice Deposit tokens to MasterChef for WILD allocation.
    /// @param _pid pool id to deposit to
    /// @param _amount amount of tokens to deposit. This amount should be approved beforehand
    /// @param _recipient lock period in seconds to lock
    function depositFor(uint256 _pid, uint256 _amount, address _recipient) external nonReentrant {
        address _sender = msg.sender;
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][_recipient];
        updatePool(_pid);
        if (user.amount > 0) {
            if (pool.isNFTPool) {
                uint256 pending = user
                    .amount
                    .mul(amountPerNFT)
                    .mul(pool.accThreeWildPerShare)
                    .div(1e18)
                    .sub(user.rewardDebt);
                if (pending > 0) {
                    safeThreeWildTransfer(_recipient, pending);
                }
            } else {
                uint256 pending = user.amount.mul(pool.accThreeWildPerShare).div(1e18).sub(
                    user.rewardDebt
                );
                if (pending > 0) {
                    safeThreeWildTransfer(_recipient, pending);
                }
            }
        }
        if (_amount > 0) {
            if (pool.isNFTPool) {
                require(IERC721(pool.lpToken).ownerOf(_amount) == _sender, "Invalid owner");
                IERC721(pool.lpToken).safeTransferFrom(_sender, address(this), _amount);
                user.amount = user.amount.add(1);
                user.tokenIds.push(_amount);
            } else {
                IERC20(pool.lpToken).safeTransferFrom(address(_sender), address(this), _amount);
                if (pool.depositFeeBP > 0) {
                    uint256 depositFee = _amount.mul(pool.depositFeeBP).div(10000);

                    IERC20(pool.lpToken).safeTransfer(feeAddress, depositFee);

                    user.amount = user.amount.add(_amount).sub(depositFee);
                } else {
                    user.amount = user.amount.add(_amount);
                }
            }
        }
        user.rewardDebt = user.amount.mul(pool.accThreeWildPerShare).div(1e18);
        emit Deposit(msg.sender, _pid, _amount);
    }

    function _deposit(uint256 _pid, uint256 _amount) internal validatePoolByPid(_pid) {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        updatePool(_pid);
        address _sender = msg.sender;
        if (user.amount > 0) {
            if (block.timestamp > user.lastHarvestTime) {
                if (user.lastHarvestTime == 0) user.lastHarvestTime = block.timestamp;
                if (block.timestamp <= user.lastHarvestTime + 1 days) {
                    if (user.harvestTimes < MAX_COMPOUND_PER_DAY) {
                        if (pool.isNFTPool) {
                            uint256 pending = user
                                .amount
                                .mul(amountPerNFT)
                                .mul(pool.accThreeWildPerShare)
                                .div(1e18)
                                .sub(user.rewardDebt);
                            if (pending > 0) {
                                safeThreeWildTransfer(msg.sender, pending);
                            }
                        } else {
                            uint256 pending = user.amount.mul(pool.accThreeWildPerShare).div(1e18).sub(
                                user.rewardDebt
                            );
                            if (pending > 0) {
                                safeThreeWildTransfer(msg.sender, pending);
                            }
                        }
                        user.harvestTimes += 1;
                    } else {
                        user.harvestTimes = 0;
                        user.lastHarvestTime = block.timestamp;
                    }
                } else {
                    user.harvestTimes = 0;
                    user.lastHarvestTime = user.lastHarvestTime + 1 days;
                }

            }

        }
        if (_amount > 0) {
            if (pool.isNFTPool) {
                require(IERC721(pool.lpToken).ownerOf(_amount) == _sender, "Invalid owner");
                IERC721(pool.lpToken).safeTransferFrom(_sender, address(this), _amount);
                user.amount = user.amount.add(1);
                user.tokenIds.push(_amount);
            } else {
                IERC20(pool.lpToken).safeTransferFrom(address(_sender), address(this), _amount);
                if (pool.depositFeeBP > 0) {
                    uint256 depositFee = _amount.mul(pool.depositFeeBP).div(10000);

                    IERC20(pool.lpToken).safeTransfer(feeAddress, depositFee);

                    user.amount = user.amount.add(_amount).sub(depositFee);
                } else {
                    user.amount = user.amount.add(_amount);
                }
            }
        }
        user.rewardDebt = user.amount.mul(pool.accThreeWildPerShare).div(1e18);
        emit Deposit(msg.sender, _pid, _amount);
    }

    // Function to harvest or compound many pools in a single transaction
    function harvestMany(uint256[] calldata _pids) public nonReentrant {
        for (uint256 index = 0; index < _pids.length; index++) {
            _deposit(_pids[index], 0);
        }
    }

    // check user's nft token id is valid
    function isValidTokenId(uint256[] memory arr, uint256 _tokenId) internal view returns (int) {
        for (int i = 0; i < int(arr.length); i++) {
            if (arr[uint256(i)] == _tokenId) {
                return i;
            }
        }
        return -1;
    }

    // Withdraw LP tokens from MasterChef.
    function withdraw(uint256 _pid, uint256 _amount) public nonReentrant {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        updatePool(_pid);
        address _sender = msg.sender;
        if (pool.isNFTPool) {
            uint256 pending = user
                .amount
                .mul(amountPerNFT)
                .mul(pool.accThreeWildPerShare)
                .div(1e18)
                .sub(user.rewardDebt);
            if (pending > 0) {
                safeThreeWildTransfer(msg.sender, pending);
            }
        } else {
            uint256 pending = user.amount.mul(pool.accThreeWildPerShare).div(1e18).sub(user.rewardDebt);
            if (pending > 0) {
                safeThreeWildTransfer(msg.sender, pending);
            }
        }

        if (_amount > 0) {
            if (pool.isNFTPool) {
                int index = isValidTokenId(user.tokenIds, _amount);
                require(index != -1, "Invalid token Id");
                delete user.tokenIds[uint256(index)];
                user.amount = user.amount.sub(1);
                IERC721(pool.lpToken).safeTransferFrom(address(this), _sender, _amount);
            } else {
                require(user.amount >= _amount, "withdraw: not good");
                if (_amount > 0) {
                    user.amount = user.amount.sub(_amount);
                    IERC20(pool.lpToken).safeTransfer(_sender, _amount);
                }
            }
        }
        user.rewardDebt = user.amount.mul(pool.accThreeWildPerShare).div(1e18);
        emit Withdraw(msg.sender, _pid, _amount);
    }

    // Withdraw without caring about rewards. EMERGENCY ONLY.
    function emergencyWithdraw(uint256 _pid) public nonReentrant {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        uint256 amount = user.amount;
        address _sender = msg.sender;
        user.amount = 0;
        user.rewardDebt = 0;
        if (pool.isNFTPool) {
            uint256[] memory _tokenIds = user.tokenIds;
            for (uint256 i = 0; i < _tokenIds.length; i++) {
                delete user.tokenIds[i];
                IERC721(pool.lpToken).safeTransferFrom(address(this), _sender, _tokenIds[i]);
            }
        } else {
            IERC20(pool.lpToken).safeTransfer(_sender, amount);
        }
        emit EmergencyWithdraw(msg.sender, _pid, amount);
    }

    // Safe threeWild transfer function, just in case if rounding error causes pool to not have enough THREEWILDs.
    function safeThreeWildTransfer(address _to, uint256 _amount) internal {
        uint256 threeWildBal = threeWild.balanceOf(address(this));
        if (_amount > threeWildBal) {
            threeWild.transfer(_to, threeWildBal);
        } else {
            threeWild.transfer(_to, _amount);
        }
    }

    // Update dev address by the previous dev.
    function dev(address _devaddr) public {
        require(msg.sender == devaddr, "dev: wut?");
        devaddr = _devaddr;
    }

    function setFeeAddress1(address _feeAddress1) public {
        require(msg.sender == feeAddress, "setFeeAddress1: FORBIDDEN");
        feeAddress = _feeAddress1;
    }

    function updateEmissionRate(uint256 _threeWildPerSecond) public onlyFinancialManager {
        massUpdatePools();
        threeWildPerSecond = _threeWildPerSecond;
    }

    function setWildX(address _threeWild) public onlyOwner {
        require(_threeWild != address(0), "Invalid Address");
        threeWild = ThreeWildToken(_threeWild);
    }

    function setAmountPerNFT(uint256 _newAmount) external onlyFinancialManager {
        require(_newAmount > 0, "invalid amount");
        amountPerNFT = _newAmount;
    }

    function setMaxCompoundPerDay(uint256 _newAmount) external onlyFinancialManager {
        require(_newAmount > 0, "invalid amount");
        MAX_COMPOUND_PER_DAY = _newAmount;
    }

    function getAmountPerNFT() public view returns (uint256) {
        return amountPerNFT;
    }
    
    function getUserStakedNFTs(uint256 _pid, address _user) public view returns (uint256[] memory ) {
        return  userInfo[_pid][_user].tokenIds;
    }
}
