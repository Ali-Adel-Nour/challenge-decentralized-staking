// SPDX-License-Identifier: MIT
pragma solidity 0.8.20; //Do not change the solidity version as it negatively impacts submission grading

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {
    ExampleExternalContract public exampleExternalContract;

    constructor(address exampleExternalContractAddress) {
        exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
    }
     uint256 public constant threshold = 1 ether;

     uint256 public deadline;
     uint256 public startTime;
    mapping(address => uint256) public balances;

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    // After some `deadline` allow anyone to call an `execute()` function
    // If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balance}()`
  event Staked(address indexed user, uint256 amount);

function stake() public payable {
    require(msg.value > 0, "Must send ETH to stake");
    balances[msg.sender] += msg.value;
    emit Staked(msg.sender, msg.value);
}
    
    // If the `threshold` was not met, allow everyone to call a `withdraw()` function to withdraw their balance
uint256 public deadline = block.timestamp + 30 seconds;

    // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend

    // Add the `receive()` special function that receives eth and calls stake()
}
