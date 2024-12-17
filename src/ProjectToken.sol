// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ProjectToken is ERC20 {
    constructor() ERC20("ProjectToken", "PTK") {
        // Mint 1 000 000 jetons avec 18 décimales à l'adresse du déployeur
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}
