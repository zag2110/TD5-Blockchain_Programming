// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MYT") {
        // Mint a total supply of tokens to the deployer
        // 1,000,000 tokens with 18 decimals
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}
