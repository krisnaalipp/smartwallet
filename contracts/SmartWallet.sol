// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract SampleWallet {

    address payable public owner;

    mapping(address => uint) public allowance;
    mapping(address => bool) public guardian;
    address payable public nextOwner;
    uint public guardiansResetCount;
    uint public constant confirmationsFromGuardiansForReset = 3;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner, aborting!");
        _;
    }

    modifier onlyGuardian() {
        require(guardian[msg.sender], "You are no guardian, aborting");
        _;
    }

    function addGuardian(address _guardian) public onlyOwner {
        guardian[_guardian] = true;
    }

    function removeGuardian(address _guardian) public onlyOwner {
        guardian[_guardian] = false;
    }

    function proposeNewOwner(address payable newOwner) public onlyGuardian {
        if(nextOwner != newOwner) {
            nextOwner = newOwner;
            guardiansResetCount = 0;
        }

        guardiansResetCount++;

        if(guardiansResetCount >= confirmationsFromGuardiansForReset) {
            owner = nextOwner;
            nextOwner = payable(address(0));
            guardiansResetCount = 0;
        }
    }

    function setAllowance(address _from, uint _amount) public onlyOwner {
        allowance[_from] = _amount;
    }

    function denySending(address _from) public onlyOwner {
        allowance[_from] = 0;
    }

    function transfer(address payable _to, uint _amount, bytes memory payload) public returns (bytes memory) {
        require(_amount <= address(this).balance, "Can't send more than the contract owns, aborting.");
        if(msg.sender != owner) {
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed to, aborting");
            allowance[msg.sender] -= _amount;
        }

        (bool success, bytes memory returnData) = _to.call{value: _amount}(payload);
        require(success, "Transaction failed, aborting");
        return returnData;
    }

    receive() external payable {}
}
