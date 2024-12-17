// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {CollectibleNFT} from "../src/CollectibleNFT.sol";
import {ProjectToken} from "../src/ProjectToken.sol";

contract BuyNFTWithERC20Test is Test {
    CollectibleNFT public nft;
    ProjectToken public token;
    address public buyer = address(0x123);

    function setUp() public {
        token = new ProjectToken();

        nft = new CollectibleNFT(address(0), 0, address(token), 10);

        token.transfer(buyer, 50);

        vm.prank(buyer); // Simuler l'action de l'acheteur
        token.approve(address(nft), 50);
    }

    function test_BuyNFTWithERC20() public {
        // Vérifiez le solde initial de l'acheteur dans ERC20
        assertEq(token.balanceOf(buyer), 50); // L'acheteur commence avec 50 jetons
        assertEq(nft.balanceOf(buyer), 0); // L'acheteur ne possède pas encore de NFT

        // Simuler l'achat d'un NFT par l'acheteur
        vm.prank(buyer); // Simuler l'action de l'acheteur
        nft.mintWithERC20(buyer);

        // Vérifiez le solde final de l'acheteur dans ERC20
        assertEq(token.balanceOf(buyer), 40); // 50 - 10 = 40
        assertEq(token.balanceOf(address(nft)), 10); // Le contrat NFT reçoit 10 jetons

        // Vérifiez que l'acheteur possède désormais un NFT
        assertEq(nft.balanceOf(buyer), 1); // L'acheteur possède 1 NFT
    }
}
