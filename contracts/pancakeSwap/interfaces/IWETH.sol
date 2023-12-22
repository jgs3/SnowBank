// SPDX-License-Identifier: UNLICENSED








<<<<<<< HEAD
=======


>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
pragma solidity ^0.8.0;

interface IWETH {
    function deposit() external payable;

    function transfer(address to, uint256 value) external returns (bool);

    function withdraw(uint256) external;
}
