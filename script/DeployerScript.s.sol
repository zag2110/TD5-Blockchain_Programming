// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {NumberStorage} from "../src/NumberStorage.sol";

contract DeployerScript is Script {
    NumberStorage public numberStorage;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        numberStorage = new NumberStorage();

        vm.stopBroadcast();
    }
}
