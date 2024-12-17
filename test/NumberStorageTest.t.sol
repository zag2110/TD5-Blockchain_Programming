// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NumberStorage} from "../src/NumberStorage.sol";

contract NumberStorageTest is Test {
    NumberStorage public numberStorage;

    function setUp() public {
        numberStorage = new NumberStorage();
        numberStorage.setNumber(0);
    }

    function test_Increment() public {
        numberStorage.increment();
        assertEq(numberStorage.storedNumber(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        numberStorage.setNumber(x);
        assertEq(numberStorage.storedNumber(), x);
    }
}
