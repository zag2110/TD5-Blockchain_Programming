// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract CounterScript is Script {
    MyNFT public myNft;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        myNft = new MyNFT();

        vm.stopBroadcast();
    }
}
