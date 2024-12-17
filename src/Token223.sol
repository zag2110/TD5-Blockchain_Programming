// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken223 {
    function transfer(address to, uint256 value, bytes calldata data) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value, bytes data);
}

contract Token223 is IToken223 {
    string public tokenName = "CustomToken223";
    string public tokenSymbol = "CTK223";
    uint8 public tokenDecimals = 18;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10 ** uint256(tokenDecimals);
        balances[msg.sender] = totalSupply; // Mint tous les jetons à l'adresse du déployeur
    }

    function transfer(address to, uint256 value, bytes calldata data) external override returns (bool) {
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value, data);

        // Si le destinataire est un contrat, appelez tokenFallback
        if (isContract(to)) {
            (bool success,) =
                to.call(abi.encodeWithSignature("tokenFallback(address,uint256,bytes)", msg.sender, value, data));
            require(success, "Receiver contract did not handle tokens properly");
        }
        return true;
    }

    function isContract(address account) private view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}
