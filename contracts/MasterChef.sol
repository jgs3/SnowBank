// SPDX-License-Identifier: UNLICENSED


<<<<<<< HEAD
=======





>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

<<<<<<< HEAD
import "./GEMToken.sol";

interface IGEMNFT {
=======
import "./SnowToken.sol";

interface ISnowNFT {
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
    function walletOfOwner(address _owner) external view returns (uint256[] memory);
}

interface IZap {
    function universalZapForCompound(
        address _inputToken,
        uint256 _amount,
        address _targetToken,
        address _recipient
    ) external returns (uint256 amountOut);
}

<<<<<<< HEAD
// MasterChef is the master of GEM. He can make GEM and he is a fair guy.
//
// Note that it's ownable and the owner wields tremendous power. The ownership
// will be transferred to a governance smart contract once GEM is sufficiently
=======
// MasterChef is the master of SNOW. He can make SNOW and he is a fair guy.
//
// Note that it's ownable and the owner wields tremendous power. The ownership
// will be transferred to a governance smart contract once SNOW is sufficiently
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
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
<<<<<<< HEAD
        // We do some fancy math here. Basically, any point in time, the amount of GEMs
        // entitled to a user but is pending to be distributed is:
        //
        //   pending reward = (user.amount * pool.accGEMPerShare) - user.rewardDebt
        //
        // Whenever a user deposits or withdraws LP tokens to a pool. Here's what happens:
        //   1. The pool's `accGEMPerShare` (and `lastRewardTime`) gets updated.
=======
        // We do some fancy math here. Basically, any point in time, the amount of SNOWs
        // entitled to a user but is pending to be distributed is:
        //
        //   pending reward = (user.amount * pool.accSnowPerShare) - user.rewardDebt
        //
        // Whenever a user deposits or withdraws LP tokens to a pool. Here's what happens:
        //   1. The pool's `accSnowPerShare` (and `lastRewardTime`) gets updated.
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
        //   2. User receives the pending reward sent to his/her address.
        //   3. User's `amount` gets updated.
        //   4. User's `rewardDebt` gets updated.
    }

    // Info of each pool.
    struct PoolInfo {
        address lpToken; // Address of LP token contract.
<<<<<<< HEAD
        uint256 allocPoint; // How many allocation points assigned to this pool. GEMs to distribute per block.
        uint256 lastRewardTime; // Last block number that GEMs distribution occurs.
        uint256 accGEMPerShare; // Accumulated GEMs per share, times 1e18. See below.
=======
        uint256 allocPoint; // How many allocation points assigned to this pool. SNOWs to distribute per block.
        uint256 lastRewardTime; // Last block number that SNOWs distribution occurs.
        uint256 accSnowPerShare; // Accumulated SNOWs per share, times 1e18. See below.
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
        uint16 depositFeeBP; // Deposit fee in basis points
        bool isNFTPool; // if lastRewardTime has passed
    }

<<<<<<< HEAD
    // The GEM TOKEN!
    GEMToken public gem;
    // The GEM Address
    address public gemAddr;
=======
    // The SNOW TOKEN!
    SnowToken public Snow;
    // The SNOW Address
    address public SnowAddr;
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
    // Zap address
    address public zapAddr;
    // Dev address.
    address public devaddr;
<<<<<<< HEAD
    // GEM tokens created per block.
    uint256 public gemPerSecond = 0;
    // total dev alloc
    uint256 public totalDevAlloc;
    // Bonus muliplier for early gem makers.
=======
    // SNOW tokens created per block.
    uint256 public SnowPerSecond = 0;
    // total dev alloc
    uint256 public totalDevAlloc;
    // Bonus muliplier for early Snow makers.
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
    uint256 public constant BONUS_MULTIPLIER = 1;
    // maximim compound per day, per user.
    // Deposit Fee address
    address public feeAddress;

    // Info of each pool.
    PoolInfo[] public poolInfo;
    // Info of each user that stakes LP tokens.
    mapping(uint256 => mapping(address => UserInfo)) public userInfo;
    // Total allocation points. Must be the sum of all allocation points in all pools.
    uint256 public totalAllocPoint = 0;
<<<<<<< HEAD
    // The timestamp when GEM mining starts.
=======
    // The timestamp when SNOW mining starts.
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
    uint256 public startTime;
    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event EmergencyWithdraw(address indexed user, uint256 indexed pid, uint256 amount);
    uint256 public amountPerNFT = 1000 ether;

    modifier validatePoolByPid(uint256 _pid) {
        require(_pid < poolInfo.length, "Pool does not exist");
        _;
    }

    constructor(
<<<<<<< HEAD
        address _gem,
=======
        address _Snow,
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
        address _devaddr,
        address _feeAddress1,
        address _zapAddr,
        uint256 _startTime
    ) {
<<<<<<< HEAD
        gem = GEMToken(_gem);
        devaddr = _devaddr;
        feeAddress = _feeAddress1;
        startTime = _startTime;
        gemAddr = _gem;
=======
        Snow = SnowToken(_Snow);
        devaddr = _devaddr;
        feeAddress = _feeAddress1;
        startTime = _startTime;
        SnowAddr = _Snow;
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
        zapAddr = _zapAddr;
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
<<<<<<< HEAD
                accGEMPerShare: 0,
=======
                accSnowPerShare: 0,
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
                depositFeeBP: _depositFeeBP,
                isNFTPool: _isNFTPool
            })
        );
    }

<<<<<<< HEAD
    // Update the given pool's GEM allocation point and deposit fee. Can only be called by the owner.
=======
    // Update the given pool's SNOW allocation point and deposit fee. Can only be called by the owner.
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
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
<<<<<<< HEAD
        if (_fromTime <= startTime) return _toTime.sub(startTime).mul(gemPerSecond);
        return _toTime.sub(_fromTime).mul(gemPerSecond);
    }

    // View function to see pending GEMs on frontend.
    function pendingGEM(uint256 _pid, address _user) external view returns (uint256) {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][_user];
        uint256 accGEMPerShare = pool.accGEMPerShare;
=======
        if (_fromTime <= startTime) return _toTime.sub(startTime).mul(SnowPerSecond);
        return _toTime.sub(_fromTime).mul(SnowPerSecond);
    }

    // View function to see pending SNOWs on frontend.
    function pendingSnow(uint256 _pid, address _user) external view returns (uint256) {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][_user];
        uint256 accSnowPerShare = pool.accSnowPerShare;
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
        if (pool.isNFTPool) {
            uint256 lpSupply = IERC721(pool.lpToken).balanceOf(address(this));
            if (block.timestamp > pool.lastRewardTime && lpSupply != 0) {
                uint256 multiplier = getMultiplier(pool.lastRewardTime, block.timestamp);
<<<<<<< HEAD
                uint256 gemReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
                accGEMPerShare = accGEMPerShare.add(
                    gemReward.mul(1e18).div(lpSupply.mul(amountPerNFT))
                );
            }
            return user.amount.mul(amountPerNFT).mul(accGEMPerShare).div(1e18).sub(user.rewardDebt);
=======
                uint256 SnowReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
                accSnowPerShare = accSnowPerShare.add(
                    SnowReward.mul(1e18).div(lpSupply.mul(amountPerNFT))
                );
            }
            return
                user.amount.mul(amountPerNFT).mul(accSnowPerShare).div(1e18).sub(user.rewardDebt);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
        } else {
            uint256 lpSupply = IERC20(pool.lpToken).balanceOf(address(this));
            if (block.timestamp > pool.lastRewardTime && lpSupply != 0) {
                uint256 multiplier = getMultiplier(pool.lastRewardTime, block.timestamp);
<<<<<<< HEAD
                uint256 gemReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
                accGEMPerShare = accGEMPerShare.add(gemReward.mul(1e18).div(lpSupply));
            }
            return user.amount.mul(accGEMPerShare).div(1e18).sub(user.rewardDebt);
=======
                uint256 SnowReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
                accSnowPerShare = accSnowPerShare.add(SnowReward.mul(1e18).div(lpSupply));
            }
            return user.amount.mul(accSnowPerShare).div(1e18).sub(user.rewardDebt);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
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
<<<<<<< HEAD
            uint256 gemReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
            GEMToken(gem).mint(devaddr, gemReward.div(5));
            GEMToken(gem).mint(address(this), gemReward);
            totalDevAlloc += gemReward.div(5);
            pool.accGEMPerShare = pool.accGEMPerShare.add(
                gemReward.mul(1e18).div(lpSupply.mul(amountPerNFT))
=======
            uint256 SnowReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
            SnowToken(Snow).mint(devaddr, SnowReward.div(5));
            SnowToken(Snow).mint(address(this), SnowReward);
            totalDevAlloc += SnowReward.div(5);
            pool.accSnowPerShare = pool.accSnowPerShare.add(
                SnowReward.mul(1e18).div(lpSupply.mul(amountPerNFT))
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
            );
            pool.lastRewardTime = block.timestamp;
        } else {
            uint256 lpSupply = IERC20(pool.lpToken).balanceOf(address(this));
            if (lpSupply == 0 || pool.allocPoint == 0) {
                pool.lastRewardTime = block.timestamp;
                return;
            }
            uint256 multiplier = getMultiplier(pool.lastRewardTime, block.timestamp);
<<<<<<< HEAD
            uint256 gemReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
            GEMToken(gem).mint(devaddr, gemReward.div(5));
            GEMToken(gem).mint(address(this), gemReward);
            totalDevAlloc += gemReward.div(5);
            pool.accGEMPerShare = pool.accGEMPerShare.add(gemReward.mul(1e18).div(lpSupply));
=======
            uint256 SnowReward = multiplier.mul(pool.allocPoint).div(totalAllocPoint);
            SnowToken(Snow).mint(devaddr, SnowReward.div(5));
            SnowToken(Snow).mint(address(this), SnowReward);
            totalDevAlloc += SnowReward.div(5);
            pool.accSnowPerShare = pool.accSnowPerShare.add(SnowReward.mul(1e18).div(lpSupply));
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
            pool.lastRewardTime = block.timestamp;
        }
    }

<<<<<<< HEAD
    // Deposit LP tokens to MasterChef for GEM allocation.
=======
    // Deposit LP tokens to MasterChef for SNOW allocation.
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
    function deposit(uint256 _pid, uint256 _amount, bool isNFTAll) public nonReentrant {
        _deposit(_pid, _amount, isNFTAll);
    }

<<<<<<< HEAD
    /// @notice Deposit tokens to MasterChef for GEM allocation.
=======
    /// @notice Deposit tokens to MasterChef for SNOW allocation.
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
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
<<<<<<< HEAD
                    .mul(pool.accGEMPerShare)
                    .div(1e18)
                    .sub(user.rewardDebt);
                if (pending > 0) {
                    safeGEMTransfer(_recipient, pending);
                }
            } else {
                uint256 pending = user.amount.mul(pool.accGEMPerShare).div(1e18).sub(
                    user.rewardDebt
                );
                if (pending > 0) {
                    safeGEMTransfer(_recipient, pending);
=======
                    .mul(pool.accSnowPerShare)
                    .div(1e18)
                    .sub(user.rewardDebt);
                if (pending > 0) {
                    safeSnowTransfer(_recipient, pending);
                }
            } else {
                uint256 pending = user.amount.mul(pool.accSnowPerShare).div(1e18).sub(
                    user.rewardDebt
                );
                if (pending > 0) {
                    safeSnowTransfer(_recipient, pending);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
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
<<<<<<< HEAD
        user.rewardDebt = user.amount.mul(pool.accGEMPerShare).div(1e18);
=======
        user.rewardDebt = user.amount.mul(pool.accSnowPerShare).div(1e18);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
        emit Deposit(msg.sender, _pid, _amount);
    }

    function _deposit(
        uint256 _pid,
        uint256 _amount,
        bool isNFTAll
    ) internal validatePoolByPid(_pid) {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        updatePool(_pid);
        address _sender = msg.sender;
        if (user.amount > 0) {
            if (pool.isNFTPool) {
                uint256 pending = user
                    .amount
                    .mul(amountPerNFT)
<<<<<<< HEAD
                    .mul(pool.accGEMPerShare)
                    .div(1e18)
                    .sub(user.rewardDebt);
                if (pending > 0) {
                    safeGEMTransfer(msg.sender, pending);
                }
            } else {
                uint256 pending = user.amount.mul(pool.accGEMPerShare).div(1e18).sub(
                    user.rewardDebt
                );
                if (pending > 0) {
                    safeGEMTransfer(msg.sender, pending);
=======
                    .mul(pool.accSnowPerShare)
                    .div(1e18)
                    .sub(user.rewardDebt);
                if (pending > 0) {
                    safeSnowTransfer(msg.sender, pending);
                }
            } else {
                uint256 pending = user.amount.mul(pool.accSnowPerShare).div(1e18).sub(
                    user.rewardDebt
                );
                if (pending > 0) {
                    safeSnowTransfer(msg.sender, pending);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
                }
            }
        }
        if (_amount > 0) {
            if (pool.isNFTPool) {
<<<<<<< HEAD
                uint256[] memory tokenIds = IGEMNFT(pool.lpToken).walletOfOwner(_sender);
=======
                uint256[] memory tokenIds = ISnowNFT(pool.lpToken).walletOfOwner(_sender);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
                if (isNFTAll) {
                    if (tokenIds.length > 0) {
                        for (uint256 i = 0; i < tokenIds.length; i++) {
                            IERC721(pool.lpToken).safeTransferFrom(
                                _sender,
                                address(this),
                                tokenIds[i]
                            );
                            user.amount = user.amount.add(1);
                            user.tokenIds.push(tokenIds[i]);
                        }
                    }
                } else {
                    require(tokenIds.length >= _amount, "Invalid token amount");
                    if (tokenIds.length > 0) {
                        for (uint256 i = 0; i < _amount; i++) {
                            IERC721(pool.lpToken).safeTransferFrom(
                                _sender,
                                address(this),
                                tokenIds[i]
                            );
                            user.amount = user.amount.add(1);
                            user.tokenIds.push(tokenIds[i]);
                        }
                    }
                }
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
        if (pool.isNFTPool) {
<<<<<<< HEAD
            user.rewardDebt = user.amount.mul(amountPerNFT).mul(pool.accGEMPerShare).div(1e18);
        } else {
            user.rewardDebt = user.amount.mul(pool.accGEMPerShare).div(1e18);
=======
            user.rewardDebt = user.amount.mul(amountPerNFT).mul(pool.accSnowPerShare).div(1e18);
        } else {
            user.rewardDebt = user.amount.mul(pool.accSnowPerShare).div(1e18);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
        }
        emit Deposit(msg.sender, _pid, _amount);
    }

    // Function to harvest or compound many pools in a single transaction
    function harvestMany(uint256[] calldata _pids) public nonReentrant {
        for (uint256 index = 0; index < _pids.length; index++) {
            _deposit(_pids[index], 0, false);
        }
    }

    // Withdraw LP tokens from MasterChef.
    function withdraw(uint256 _pid, uint256 _amount, bool isNFTAll) public nonReentrant {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        updatePool(_pid);
        address _sender = msg.sender;
        if (pool.isNFTPool) {
<<<<<<< HEAD
            uint256 pending = user.amount.mul(amountPerNFT).mul(pool.accGEMPerShare).div(1e18).sub(
                user.rewardDebt
            );
            if (pending > 0) {
                safeGEMTransfer(msg.sender, pending);
            }
        } else {
            uint256 pending = user.amount.mul(pool.accGEMPerShare).div(1e18).sub(user.rewardDebt);
            if (pending > 0) {
                safeGEMTransfer(msg.sender, pending);
=======
            uint256 pending = user.amount.mul(amountPerNFT).mul(pool.accSnowPerShare).div(1e18).sub(
                user.rewardDebt
            );
            if (pending > 0) {
                safeSnowTransfer(msg.sender, pending);
            }
        } else {
            uint256 pending = user.amount.mul(pool.accSnowPerShare).div(1e18).sub(user.rewardDebt);
            if (pending > 0) {
                safeSnowTransfer(msg.sender, pending);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
            }
        }

        if (_amount > 0) {
            if (pool.isNFTPool) {
                uint256[] memory _tokenIds = user.tokenIds;
                if (isNFTAll) {
                    if (_tokenIds.length > 0) {
                        uint256[] memory empyArr;
                        user.tokenIds = empyArr;
                        for (uint256 i = 0; i < _tokenIds.length; i++) {
                            user.amount = user.amount.sub(1);
                            IERC721(pool.lpToken).safeTransferFrom(
                                address(this),
                                _sender,
                                _tokenIds[i]
                            );
                        }
                    }
                } else {
                    require(_tokenIds.length >= _amount, "Invalid token amount");
                    if (_tokenIds.length > 0) {
                        uint256[] memory newArr = new uint256[](_tokenIds.length - _amount);
                        for (uint256 i = _amount; i < _tokenIds.length; i++) {
                            newArr[i - _amount] = _tokenIds[i];
                        }
                        user.tokenIds = newArr;
                        for (uint256 i = 0; i < _amount; i++) {
                            user.amount = user.amount.sub(1);
                            IERC721(pool.lpToken).safeTransferFrom(
                                address(this),
                                _sender,
                                _tokenIds[i]
                            );
                        }
                    }
                }
            } else {
                require(user.amount >= _amount, "withdraw: not good");
                if (_amount > 0) {
                    user.amount = user.amount.sub(_amount);
                    IERC20(pool.lpToken).safeTransfer(_sender, _amount);
                }
            }
        }
<<<<<<< HEAD
        user.rewardDebt = user.amount.mul(pool.accGEMPerShare).div(1e18);
=======
        user.rewardDebt = user.amount.mul(pool.accSnowPerShare).div(1e18);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
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
            uint256[] memory empyArr;
            user.tokenIds = empyArr;
            for (uint256 i = 0; i < _tokenIds.length; i++) {
                IERC721(pool.lpToken).safeTransferFrom(address(this), _sender, _tokenIds[i]);
            }
        } else {
            IERC20(pool.lpToken).safeTransfer(_sender, amount);
        }
        emit EmergencyWithdraw(msg.sender, _pid, amount);
    }

<<<<<<< HEAD
    // Safe gem transfer function, just in case if rounding error causes pool to not have enough GEMs.
    function safeGEMTransfer(address _to, uint256 _amount) internal {
        uint256 gemBal = gem.balanceOf(address(this));
        if (_amount > gemBal) {
            gem.transfer(_to, gemBal);
        } else {
            gem.transfer(_to, _amount);
=======
    // Safe Snow transfer function, just in case if rounding error causes pool to not have enough SNOWs.
    function safeSnowTransfer(address _to, uint256 _amount) internal {
        uint256 SnowBal = Snow.balanceOf(address(this));
        if (_amount > SnowBal) {
            Snow.transfer(_to, SnowBal);
        } else {
            Snow.transfer(_to, _amount);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
        }
    }

    function compound(uint256 _pid) public nonReentrant {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        uint256 amountOut = 0;
        updatePool(_pid);
        if (user.amount > 0) {
<<<<<<< HEAD
            uint256 pending = user.amount.mul(pool.accGEMPerShare).div(1e18).sub(user.rewardDebt);
            uint256 gemBal = gem.balanceOf(address(this));

            if (user.amount > 0) {
                if (pending > 0) {
                    if (pending > gemBal) {
                        IERC20(gemAddr).safeIncreaseAllowance(address(zapAddr), gemBal);
                        amountOut = IZap(zapAddr).universalZapForCompound(
                            gemAddr, //_inputToken
                            gemBal, //_amount
=======
            uint256 pending = user.amount.mul(pool.accSnowPerShare).div(1e18).sub(user.rewardDebt);
            uint256 SnowBal = Snow.balanceOf(address(this));

            if (user.amount > 0) {
                if (pending > 0) {
                    if (pending > SnowBal) {
                        IERC20(SnowAddr).safeIncreaseAllowance(address(zapAddr), SnowBal);
                        amountOut = IZap(zapAddr).universalZapForCompound(
                            SnowAddr, //_inputToken
                            SnowBal, //_amount
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
                            pool.lpToken, //_targetToken
                            address(this) //_recipient
                        );
                    } else {
<<<<<<< HEAD
                        IERC20(gemAddr).safeIncreaseAllowance(address(zapAddr), pending);
                        amountOut = IZap(zapAddr).universalZapForCompound(
                            gemAddr, //_inputToken
=======
                        IERC20(SnowAddr).safeIncreaseAllowance(address(zapAddr), pending);
                        amountOut = IZap(zapAddr).universalZapForCompound(
                            SnowAddr, //_inputToken
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
                            pending, //_amount
                            pool.lpToken, //_targetToken
                            address(this) //_recipient
                        );
                    }
                }
            }

            if (amountOut > 0) {
                if (pool.depositFeeBP > 0) {
                    uint256 depositFee = amountOut.mul(pool.depositFeeBP).div(10000);
                    IERC20(pool.lpToken).safeTransfer(feeAddress, depositFee);
                    user.amount = user.amount.add(amountOut).sub(depositFee);
                } else {
                    user.amount = user.amount.add(amountOut);
                }
            }
<<<<<<< HEAD
            user.rewardDebt = user.amount.mul(pool.accGEMPerShare).div(1e18);
=======
            user.rewardDebt = user.amount.mul(pool.accSnowPerShare).div(1e18);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
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

<<<<<<< HEAD
    function updateEmissionRate(uint256 _gemPerSecond) public onlyOwner {
        massUpdatePools();
        gemPerSecond = _gemPerSecond;
    }

    function setGemX(address _gem) public onlyOwner {
        require(_gem != address(0), "Invalid Address");
        gem = GEMToken(_gem);
=======
    function updateEmissionRate(uint256 _SnowPerSecond) public onlyOwner {
        massUpdatePools();
        SnowPerSecond = _SnowPerSecond;
    }

    function setSnowX(address _Snow) public onlyOwner {
        require(_Snow != address(0), "Invalid Address");
        Snow = SnowToken(_Snow);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
    }

    function setAmountPerNFT(uint256 _newAmount) external onlyOwner {
        require(_newAmount > 0, "invalid amount");
        amountPerNFT = _newAmount;
    }

    function getAmountPerNFT() public view returns (uint256) {
        return amountPerNFT;
    }

    function getUserStakedNFTs(uint256 _pid, address _user) public view returns (uint256[] memory) {
        return userInfo[_pid][_user].tokenIds;
    }

    function setMaxTaxRate(uint256 _newMaxRate) external onlyOwner {
        GEMToken(gem).setMaxTaxRate(_newMaxRate);
    }

    function setStaticTaxRate(uint256 _newStaticRate) external onlyOwner {
        GEMToken(gem).setStaticTaxRate(_newStaticRate);
    }
}
