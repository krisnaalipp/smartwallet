// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract BlockChainMessenger {
    address public owner = msg.sender;

    uint256 public changeCounter;

    string public theMessage;

    function updateMessage(string memory message) public {
        if (msg.sender == owner) {
            theMessage = message;
            changeCounter++;
        }
    }
}
