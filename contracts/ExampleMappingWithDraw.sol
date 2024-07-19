// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleMappingWithDraw {

    mapping(address => uint) public  balanceReceived;

    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function getBalance() public view returns(uint)  {
        return address(this).balance;
    }

    function withDrawMoney(address payable _to) public {
        uint balanceToSendout = balanceReceived[msg.sender]; //untuk misahin address dan balance yang bakal di withdraw di tiap address
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSendout);
    }

}