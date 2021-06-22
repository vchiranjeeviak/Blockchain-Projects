This is a project on Smart Contracts

In this project, we are creating a shared wallet which has an owner who can allocate allowances to other accounts. All the accounts including owner can withdraw money from the smart contract. But, the owner can withdraw any amount available in the smart contract and the other account can only withdraw the amount that is allocated to them by the owner as allowance. In this smart contract, we can't renounce the owner i.e we can't remove owner of the smart contract as any of the functionality can't work if we do so. This is because the maximum of functionality is dependent on the owner.

The external code used in the project are :-
  1. Ownable contract from OpenZeppelin.
  2. SafeMath library from OpenZeppelin.

This project can be used as a or skelton for other big scale projects which need shared wallets etc.
