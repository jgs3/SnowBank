// SPDX-License-Identifier: UNLICENSED














<<<<<<< HEAD
=======


>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
pragma solidity ^0.8.15;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Part: IERC20Taxable

interface IERC20Taxable is IERC20 {
    function getCurrentTaxRate() external returns (uint256);
}
