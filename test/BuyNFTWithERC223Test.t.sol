// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {MyNFT} from "../src/MyNFT.sol";
import {ERC223Token} from "../src/ERC223Token.sol";

contract BuyNFTWithERC223Test is Test {
    MyNFT public nft;
    ERC223Token public token;
    address public buyer = address(0x123); // Adresse fictive de l'acheteur
    address public seller = address(this); // Adresse du déployeur comme vendeur

    function setUp() public {
        // Déployer le contrat ERC223 avec un total supply de 1000
        token = new ERC223Token(1000);

        // Déployer le contrat NFT avec le prix en ERC223 fixé à 10
        nft = new MyNFT(address(token), 10, address(0), 0); // Pas besoin d'ERC20 pour ce test

        // Transférer des tokens ERC223 au buyer pour le test
        token.transfer(buyer, 50, "");
    }

    function test_BuyNFTWithERC223() public {
        // Vérifiez le solde initial du buyer en ERC223
        assertEq(token.balanceOf(buyer), 50); // Le buyer commence avec 50 tokens
        assertEq(nft.balanceOf(buyer), 0);   // Le buyer n'a pas encore de NFT

        // Simulez le transfert de tokens ERC223 par le buyer pour acheter un NFT
        vm.prank(buyer); // Simule que le buyer effectue cette action
        token.transfer(address(nft), 10, ""); // Transfert des tokens ERC223

        // Vérifiez le solde final du buyer en ERC223
        assertEq(token.balanceOf(buyer), 40); // 50 - 10 = 40
        assertEq(token.balanceOf(address(nft)), 10); // Le contrat NFT reçoit 10 tokens

        // Vérifiez que le buyer possède bien un NFT
        assertEq(nft.balanceOf(buyer), 1); // Le buyer a maintenant 1 NFT
    }
}
