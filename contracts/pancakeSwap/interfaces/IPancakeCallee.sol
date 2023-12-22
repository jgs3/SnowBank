// SPDX-License-Identifier: UNLICENSED








<<<<<<< HEAD
=======


>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
pragma solidity ^0.8.0;

interface IPancakeCallee {
    function pancakeCall(
        address sender,
        uint256 amount0,
        uint256 amount1,
        bytes calldata data
    ) external;
}
