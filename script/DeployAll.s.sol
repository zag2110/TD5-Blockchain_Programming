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
        // Définir les arguments requis pour le constructeur
        address paymentToken223 = 0x1234567890123456789012345678901234567890; // Remplace par l'adresse ERC223
        uint256 price223 = 10 * 1e18; // Prix de 10 tokens ERC223
        address paymentToken20 = 0x9876543210987654321098765432109876543210; // Remplace par l'adresse ERC20
        uint256 price20 = 20 * 1e18; // Prix de 20 tokens ERC20

        vm.startBroadcast();

        // Déployer les autres contrats
        myToken = new MyToken();
        erc223Token = new ERC223Token(1000000);

        // Passer les arguments au constructeur
        myNFT = new MyNFT(paymentToken223, price223, paymentToken20, price20);

        vm.stopBroadcast();
    }
}
