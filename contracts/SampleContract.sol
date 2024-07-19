// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract SampleContract {
    string public theString = "Hiii";

    function changeString(string memory _paramString) public payable {
        if(msg.value == 1 ether) {
        theString = _paramString;
        payable(msg.sender).transfer(1 ether);
        } else {
            payable(msg.sender).transfer(msg.value);
        }
    }
}