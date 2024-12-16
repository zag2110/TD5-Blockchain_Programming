// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


contract MyNFT is ERC721 {
    uint256 public nextTokenId;
    address public paymentToken223; // Adresse du contrat ERC223
    IERC20 public paymentToken20;   // Contrat ERC20 pour le paiement
    uint256 public price223;        // Prix d'un NFT en ERC223
    uint256 public price20;         // Prix d'un NFT en ERC20

    constructor(address _paymentToken223, uint256 _price223, address _paymentToken20, uint256 _price20) ERC721("MyNFT", "MNFT") {
        paymentToken223 = _paymentToken223;
        price223 = _price223;
        paymentToken20 = IERC20(_paymentToken20);
        price20 = _price20;
    }

    // Mint automatique avec ERC223 via `tokenFallback`
    function tokenFallback(address from, uint256 value, bytes calldata data) external {
        require(msg.sender == paymentToken223, "Only the designated ERC223 token can be used");
        require(value >= price223, "Insufficient ERC223 tokens sent");

        uint256 tokenId = nextTokenId;
        nextTokenId++;
        _mint(from, tokenId);
    }

    // Mint avec ERC20
    function mintWithERC20(address to) public {
        require(paymentToken20.balanceOf(msg.sender) >= price20, "Insufficient ERC20 balance");
        require(paymentToken20.allowance(msg.sender, address(this)) >= price20, "Allowance too low");

        // Transfert des tokens ERC20 au contrat
        paymentToken20.transferFrom(msg.sender, address(this), price20);

        // Mint du NFT
        uint256 tokenId = nextTokenId;
        nextTokenId++;
        _mint(to, tokenId);
    }
}
