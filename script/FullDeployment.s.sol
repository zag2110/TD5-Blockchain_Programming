// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/ProjectToken.sol";
import "../src/Token223.sol";
import "../src/CollectibleNFT.sol";

contract FullDeployment is Script {
    ProjectToken public projectToken;
    Token223 public token223;
    CollectibleNFT public collectibleNFT;

    function run() public {
        // Les arguments définis ici sont à destination des constructeurs
        address token223Address = 0xABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCD; // L'adresse du contrat ERC223
        uint256 nftPrice223 = 15 * 1e18; // Ici le prix de 15 tokens ERC223 pour un NFT
        address token20Address = 0xDEF0123456789ABCDEF0123456789ABCDEF01234; // Ici l'adresse ERC20
        uint256 nftPrice20 = 25 * 1e18; // Ici le prix de 25 tokens ERC20 pour un NFT

        vm.startBroadcast();

        // Déploiement des contrats
        projectToken = new ProjectToken();
        token223 = new Token223(1000000);

        // Déploiement du contrat CollectibleNFT
        collectibleNFT = new CollectibleNFT(token223Address, nftPrice223, token20Address, nftPrice20);

        vm.stopBroadcast();
    }
}
