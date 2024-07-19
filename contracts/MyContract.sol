// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract MyContract {
    string public ourString = "Hello Word Hiii";


    function updateString(string memory _updateString) public {
        ourString = _updateString;
    }

    address public myAddress;

    constructor(address _address) {
        myAddress = _address;
    }

    function setAddress(address _addressInput) public {
        myAddress = _addressInput;
    }

    function getBalance() public view returns (uint256) {
        return myAddress.balance;
    }

    uint8 public number = 0;

    function decrement() public {
        number--;
    }
}
