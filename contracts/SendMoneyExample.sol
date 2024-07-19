// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract SendWithDrawMoney {
    uint256 public balanceReceived;

    function deposit() public payable {
        balanceReceived += msg.value;
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withDrawAll() public  {
        address payable to = payable (msg.sender);
        to.transfer(getContractBalance());
    }

    function withdrawToAddress(address payable to) public {
        to.transfer(getContractBalance());
    }
}
