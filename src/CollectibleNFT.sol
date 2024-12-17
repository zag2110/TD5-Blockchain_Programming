// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract CollectibleNFT is ERC721 {
    uint256 public nextTokenId;
    address public erc223Token; // L'adresse du contrat ERC223
    IERC20 public erc20Token; // Contrat de token ERC220 pour le paiement
    uint256 public price223; // Prix ​​en ERC223 pour un seul NFT
    uint256 public price20; // Prix ​​en ERC20 pour un seul NFT

    constructor(address _erc223Token, uint256 _price223, address _erc20Token, uint256 _price20)
        ERC721("CustomCollectibleNFT", "CCNFT")
    {
        erc223Token = _erc223Token;
        price223 = _price223;
        erc20Token = IERC20(_erc20Token);
        price20 = _price20;
    }

    // Mint avec ERC223 utilisant `tokenFallback`
    function tokenFallback(address from, uint256 value, bytes calldata data) external {
        require(msg.sender == erc223Token, "Only the designated ERC223 token can be used");
        require(value >= price223, "Insufficient ERC223 tokens sent");

        uint256 tokenId = nextTokenId;
        nextTokenId++;
        _mint(from, tokenId);
    }

    // Mint avec ERC20
    function mintWithERC20(address to) public {
        require(erc20Token.balanceOf(msg.sender) >= price20, "Insufficient ERC20 balance");
        require(erc20Token.allowance(msg.sender, address(this)) >= price20, "Allowance too low");

        // Transférer les tokens ERC20 vers le contrat
        erc20Token.transferFrom(msg.sender, address(this), price20);

        // Mint le NFT
        uint256 tokenId = nextTokenId;
        nextTokenId++;
        _mint(to, tokenId);
    }
}
