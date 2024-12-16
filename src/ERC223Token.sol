// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC223 {
    function transfer(address to, uint256 value, bytes calldata data) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value, bytes data);
}

contract ERC223Token is IERC223 {
    string public name = "MyToken223";
    string public symbol = "MYT223";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * 10**uint256(decimals);
        balanceOf[msg.sender] = totalSupply; // Mint all tokens to deployer
    }

    function transfer(address to, uint256 value, bytes calldata data) external override returns (bool) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value, data);

        // Check if recipient is a contract
        if (isContract(to)) {
            (bool success,) = to.call(abi.encodeWithSignature("tokenFallback(address,uint256,bytes)", msg.sender, value, data));
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
