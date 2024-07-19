// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MappingStruct {
    struct Transaction {
        uint256 amount;
        uint256 timestamp;
    }

    struct Balance {
        uint256 totalBalance;
        uint256 numDeposits;
        mapping(uint256 => Transaction) deposits;
        uint256 numWithDrawals;
        mapping(uint256 => Transaction) withdrawals;
    }

    mapping(address => Balance) public balanceReceived;

    function getBalance(address _address) public view returns (uint256) {
        return balanceReceived[_address].totalBalance;
    }

    function depositMoney() public payable {
        balanceReceived[msg.sender].totalBalance += msg.value;

        Transaction memory deposit = Transaction(msg.value, block.timestamp);

        balanceReceived[msg.sender].deposits[
            balanceReceived[msg.sender].numDeposits
        ] = deposit;
        balanceReceived[msg.sender].numDeposits++;
    }

    function withDrawMoney(uint256 _amount, address payable _to)
        public
        payable
    {
        balanceReceived[msg.sender].totalBalance -= _amount;

        Transaction memory withdraw = Transaction(msg.value, block.timestamp);

        balanceReceived[msg.sender].withdrawals[
            balanceReceived[msg.sender].numWithDrawals
        ] = withdraw;
        balanceReceived[msg.sender].numWithDrawals++;

        _to.transfer(_amount);
    }
}

contract RequireLesson {
    mapping(address => uint256) public balanceReceived;

    function depositMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount, address payable to) public {
        require(amount <= balanceReceived[msg.sender], "Not enough fund");
        to.transfer(amount);
    }
}
