// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import "./ExampleExternalContract.sol";

contract Staker {
    ExampleExternalContract public exampleExternalContract;

    constructor(address exampleExternalContractAddress) {
        exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
    }

    uint256 public constant threshold = 1 ether;
    uint256 public deadline = block.timestamp + 72 hours;
    uint256 public startTime = block.timestamp;
    mapping(address => uint256) public balances;
    event Staked(address user, uint256 amount);

    function stake() public payable {
        require(msg.value > 0, "Must send ETH to stake");
        balances[msg.sender] += msg.value;
        console.log("Staking:", msg.sender, msg.value);
        // console.log("Staking:", msg.sender, msg.value);
    }

    function execute() external {
        require(block.timestamp >= deadline, "Deadline not reached");
        if (address(this).balance >= threshold) {
            exampleExternalContract.complete{ value: address(this).balance }();
        }
    }

    function withdraw() external {
        require(block.timestamp >= deadline, "Deadline not reached");
        require(address(this).balance < threshold, "Threshold met, cannot withdraw");
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function timeLeft() public view returns (uint256) {
        if (block.timestamp >= deadline) {
            return 0;
        }
        return deadline - block.timestamp;
    }

    receive() external payable {
        stake();
    }
}
