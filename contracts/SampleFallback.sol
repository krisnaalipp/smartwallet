// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Fallback {
    uint256 public lastValueSent;
    string public lastFunction;

    receive() external payable {
        lastValueSent = msg.value;
        lastFunction = "receiver";
    }

    fallback() external payable {
        lastValueSent = msg.value;
        lastFunction = "receiver";
    }
}
