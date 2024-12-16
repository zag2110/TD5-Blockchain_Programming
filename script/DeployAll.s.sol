// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/MyToken.sol";
import "../src/ERC223Token.sol";
import "../src/MyNFT.sol";

contract DeployAll is Script {
    MyToken public myToken;
    ERC223Token public erc223Token;
    MyNFT public myNFT;

    function run() public {
        vm.startBroadcast();

        myToken = new MyToken();
        erc223Token = new ERC223Token(1000000);
        myNFT = new MyNFT();

        vm.stopBroadcast();
    }
}

