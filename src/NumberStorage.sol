// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract NumberStorage {
    uint256 public storedNumber;

    function setNumber(uint256 newNumber) public {
        storedNumber = newNumber;
    }

    function increment() public {
        storedNumber++;
    }
}
