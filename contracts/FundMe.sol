// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
	using PriceConverter for uint256;

	mapping (address => uint256) public addressToAmountFunded;
	address[] public funders;

	address public owner;
	address public oracleAddress;
  uint256 public MINIMUM_USD;

	constructor(address oracleAddress_, uint256 minimumUsd) {
		oracleAddress = oracleAddress_;
		owner = msg.sender;
		MINIMUM_USD = minimumUsd * 1e18;
	}

	modifier onlyOwner {
		if (msg.sender != owner) revert NotOwner();
		_;
	}

	function getVersion(address _oracleAddress) public view returns (uint256) {
		AggregatorV3Interface dataFeed = AggregatorV3Interface(_oracleAddress);
		return dataFeed.version();
	}

	function fund() public payable {
		require(msg.value.getConversionRate(oracleAddress) >= MINIMUM_USD, "You need to spend more ETH!");
		funders.push(msg.sender);
		addressToAmountFunded[msg.sender] += msg.value;
	}

	function withdraw() public onlyOwner() {
		for (uint funderIndex = 0; funderIndex < funders.length; funderIndex++) {
			addressToAmountFunded[funders[funderIndex]] = 0;
		}
		funders = new address[](0);
		(bool successWithdraw,) = payable(msg.sender).call{value: address(this).balance}("");
		require(successWithdraw, "Withdraw failed");
	}

	fallback() external payable {
		fund();
	}

	receive() external payable {
		fund();
	}
}