// SPDX-License-Identifier: UNLICENSED



pragma solidity ^0.8.15;

contract Test {

  string public baseURI;
  string public baseExtension = ".png";

  event Received(address, uint);

  function _baseURI() internal view virtual returns (string memory) {
    return baseURI;
  }
}