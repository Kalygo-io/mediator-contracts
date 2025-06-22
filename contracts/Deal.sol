// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract Deal {
    address public buyer; // Buyer and seller state variables
    address public seller;
    bool public arbitrationFlag; // arbitration flag
    address public evaluatorAddress; // evaluator address
    uint256 public limitationDate; // limitation date
    
    constructor(
        address _buyer,
        address _seller,
        address _evaluatorAddress,
        uint256 _limitationDate
    ) {
        buyer = _buyer;
        seller = _seller;
        evaluatorAddress = _evaluatorAddress;
        limitationDate = _limitationDate;

        // default arbitration to pending
        arbitrationFlag = false;
    }

    // escrow deposit
    function deposit() external payable {
        require(msg.sender == buyer, "Only the buyer deposits escrow");
    }

    // Close the deal and pay the seller the escrow amount if the limitation date has been reached
    function closeDeal() external {
        require(block.timestamp >= limitationDate, "The limitation date has not been reached");

        // Release the escrow funds to the seller
        payable(seller).transfer(address(this).balance);
    }

    // Start arbitration
    function startArbitration() external {
        require(msg.sender == buyer || msg.sender == seller, "Only the buyer or seller can start arbitration");
        require(arbitrationFlag == false, "Arbitration is already in progress");

        // set the arbitration flag to true
        arbitrationFlag = true;
    }

    function handleArbitrationResults(address winner) external {
        require(msg.sender == evaluatorAddress, "Only the evaluator can handle arbitration results");
        require(arbitrationFlag == true, "Arbitration is not in progress");

        arbitrationFlag = false;
    }
}