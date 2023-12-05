// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.15;

import "./PriceConverter.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SNOWPresaleFork is ReentrancyGuard {
    using PriceConverter for uint256;
    // IERC20(); // localhost

    IERC20 public SNOW; // mainnet    to be adjusted
    // IERC20(); // localhost
    address public owner;
    mapping(address => uint256) public user_deposits;
    mapping(address => uint256) public user_withdraw_amount;
    mapping(address => uint256) public user_withdraw_timestamp;
    mapping(address => uint256) public SNOWOwned;

    uint256 public users_timeStamp;
    uint256 public total_deposited;
    uint256 public finishedTimestamp;
    uint256 public vestingPeriod = 20 days;

    uint256 public presalePriceOfToken = 1;
    uint256 public MAX_AMOUNT = 250 * 1e18;

    bool public enabled = true;
    bool public sale_finalized = true;
    event Received(address, uint);

    // CUSTOM ERRORS

    error SaleIsNotActive();
    error ZeroAddress();
    error SaleIsNotFinalizedYet();

    constructor(address _snow) {
        SNOW = IERC20(_snow);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the Owner!");
        _;
    }

    function getUserDeposits(address user) public view returns (uint256) {
        return user_deposits[user];
    }

    function getSNOWOwned(address user) public view returns (uint256) {
        return SNOWOwned[user];
    }

    function getClaimedAmount(address user) public view returns (uint256) {
        return user_withdraw_amount[user];
    }

    function getTotalRaised() external view returns (uint256) {
        return total_deposited;
    }

    function withdrawSNOW() external nonReentrant {
        if (!sale_finalized) revert SaleIsNotFinalizedYet();
        uint256 total_to_send = SNOWOwned[msg.sender];
        require(total_to_send > 0, "Insufficient SNOW owned by user");

        if (user_withdraw_timestamp[msg.sender] < finishedTimestamp) {
            user_withdraw_timestamp[msg.sender] = finishedTimestamp;
            users_timeStamp = user_withdraw_timestamp[msg.sender];
        }

        require(
            SNOWOwned[msg.sender] > user_withdraw_amount[msg.sender],
            "you already claimed all tokens"
        );

        require(
            block.timestamp - user_withdraw_timestamp[msg.sender] >= 1 days,
            "You cannot withdraw SNOW token yet"
        );

        uint256 availableAmount = getAmountToWithdraw(msg.sender);

        uint256 contractBalance = SNOW.balanceOf(address(this));
        require(contractBalance >= availableAmount, "Insufficient contract balance");

        user_withdraw_timestamp[msg.sender] = block.timestamp;
        user_withdraw_amount[msg.sender] += availableAmount;
        SNOW.transfer(msg.sender, availableAmount);
    }

    function setSnowOwned(address[] memory _users, uint256[] memory _SNOWOwned) public onlyOwner {
        for (uint256 i = 0; i < _users.length; i++) {
            SNOWOwned[_users[i]] = _SNOWOwned[i];
        }
    }

    function getAmountToWithdraw(address _user) public view returns (uint256) {
        if (!sale_finalized) return 0;
        if (user_withdraw_timestamp[msg.sender] == 0) return 0;
        if (block.timestamp - user_withdraw_timestamp[msg.sender] < 1 days) {
            return 0;
        } else {
            uint256 amount = (SNOWOwned[_user] * 5) / 100;
            return amount;
        }
    }

    function changeOwner(address _address) external onlyOwner {
        if (_address == address(0)) revert ZeroAddress();
        owner = _address;
    }

    function setSNOWAddress(IERC20 _SNOW) public onlyOwner {
        SNOW = _SNOW;
    }

    function setPrice(uint256 _newPrice) public onlyOwner {
        presalePriceOfToken = _newPrice;
    }

    function setFinishedTimeStamp(uint256 _finishedTimestamp) public onlyOwner {
        finishedTimestamp = _finishedTimestamp;
    }

    function withdraw() external onlyOwner {
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    function withdrawExtraToken(address _token) external onlyOwner {
        IERC20(_token).transfer(owner, IERC20(_token).balanceOf(address(this)));
    }

    function setfinalizeSale() public onlyOwner {
        sale_finalized = !sale_finalized;
    }

    function setfinishedTimestamp() public onlyOwner {
        finishedTimestamp = finishedTimestamp;
    }

    function finalizeSale() external onlyOwner {
        sale_finalized = true;
        finishedTimestamp = block.timestamp;
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
}
