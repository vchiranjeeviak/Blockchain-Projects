// "SPDX-License-Identifier: UNLICENSED"

pragma solidity ^0.8.0;

// Importing Ownable Contract from OpenZeppelin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

// Importing SafeMath library from OpenZeppelin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

// Creating a contrat named "Allowance" and inheriting Ownable contract into it
contract Allowance is Ownable{
    
    // Using SafeMath to take care of any overflows in uint operations
    using SafeMath for uint;
    
    // Creating an event which triggers whenever any change occurs to an allowance
    event allowanceChanged(address indexed _to, address indexed _from, uint _oldAmount, uint _newAmount);    
    
    // Creating allowance mapping which stores the allowances of each address
    mapping(address => uint) allowance;
    
    // Function to add allowance to an address 
    // It can only called by owner of the contract
    function addAllowance(address _address, uint _amount) public onlyOwner{
        emit allowanceChanged(_address, msg.sender, allowance[_address], _amount); // Triggering allowanceChanged event
        allowance[_address] = _amount;
    }

    // Creating a modifier which checks the allowance amount and transacting amount
    modifier ownerOrAllowed(uint _amount){
        require(owner() == msg.sender || allowance[msg.sender] >= _amount, "You are not allowed.");
        _;
    }
    
    // Function to reduce the allowance when withdrawn
    function reduceAllowance(address _address, uint _amount) internal {
        emit allowanceChanged(_address, msg.sender, allowance[_address], allowance[_address].sub(_amount)); // Triggering allowanceChanged event
        allowance[_address] = allowance[_address].sub(_amount);
    }
    
}
