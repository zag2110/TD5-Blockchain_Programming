// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {MyNFT} from "../src/MyNFT.sol";
import {MyToken} from "../src/MyToken.sol";

contract BuyNFTWithERC20Test is Test {
    MyNFT public nft;
    MyToken public token;  
    address public buyer = address(0x123);

    function setUp() public {

        token = new MyToken();

        nft = new MyNFT(address(0), 0, address(token), 10);

        token.transfer(buyer, 50);

        vm.prank(buyer); // Simuler l'action par le buyer
        token.approve(address(nft), 50);
    }

    function test_BuyNFTWithERC20() public {
        // Vérifier le solde initial du buyer en ERC20
        assertEq(token.balanceOf(buyer), 50); // Le buyer commence avec 50 tokens
        assertEq(nft.balanceOf(buyer), 0);   // Le buyer n'a pas encore de NFT

        // Simuler l'achat d'un NFT par le buyer
        vm.prank(buyer); // Simuler l'action par le buyer
        nft.mintWithERC20(buyer);

        // Vérifier le solde final du buyer en ERC20
        assertEq(token.balanceOf(buyer), 40);       // 50 - 10 = 40
        assertEq(token.balanceOf(address(nft)), 10); // Le contrat NFT reçoit 10 tokens

        // Vérifier que le buyer possède bien un NFT
        assertEq(nft.balanceOf(buyer), 1); // Le buyer possède 1 NFT
    }
}
