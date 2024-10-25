// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Fundraiser {
    address public organizer;
    uint256 public targetAmount;
    uint256 public totalContributions;
    mapping(address => uint256) public donors;

    constructor(uint256 _targetAmount) {
        organizer = msg.sender;
        targetAmount = _targetAmount;
    }

    receive() external payable {
        donate(msg.value);
    }

    function donate(uint256 _donationAmount) public payable {
        require(totalContributions < targetAmount, "Target already achieved");
        require(_donationAmount > 0, "Donation amount must be greater than 0");

        uint256 remainingAmount = targetAmount - totalContributions;
        uint256 donation = _donationAmount;

        if (donation > remainingAmount) {
            donation = remainingAmount;
        }

        donors[msg.sender] += donation;
        totalContributions += donation;

        if (totalContributions >= targetAmount) {
            emit TargetAchieved();
        }
    }

    function collectFunds() public {
        require(msg.sender == organizer, "Only the organizer can collect funds");
        require(totalContributions >= targetAmount, "Target not achieved");

        payable(organizer).transfer(totalContributions);
        totalContributions = 0;
    }

    event TargetAchieved();
}
