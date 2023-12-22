// SPDX-License-Identifier: UNLICENSED








<<<<<<< HEAD
=======


>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MockToken is ERC20, Ownable {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
