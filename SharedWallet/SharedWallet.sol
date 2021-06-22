//"SPDX-License-Identifier: UNLICENSED"

pragma solidity ^0.8.0;

// Importing Allowance.sol
import "./Allowance.sol";

//Creating SharedWallet contract which inherits Allowance contract 
contract SharedWallet is Allowance{
    
    // Creating moneySent event which triggers when money is sent
    event moneySent(address indexed _to, uint _amount);
    
    // Creating moneyReceived event which triggers when money is received
    event moneyReceived(address indexed _from, uint _amount);

    // Function to withdraw money which uses ownerOrAllowed modifier   
    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount){
        require(_amount <= address(this).balance, "Not enough funds in smart contract.");
        if(owner()!=msg.sender){
            reduceAllowance(msg.sender, _amount);
        }
        emit moneySent(_to, _amount); // Triggering moneySent event
        _to.transfer(_amount); // Transfering amount to the specified address
    }
    
    // Overriding renounceOwnership function from Ownable contract
    function renounceOwnership() override pure public {
        revert("Can't renounce in here.");
    }
    
    // receive function to receive plain ether transfer to the contract
    receive() external payable{
        emit moneyReceived(msg.sender, msg.value);
    }
}
