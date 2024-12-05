// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

contract FundMe {
	using PriceConverter for uint256;

	mapping (address => uint256) public addressToAmountFunded;
	address[] public funders;

	address public owner;
	address public oracleAddress;
  uint256 public constant MINIMUM_USD = 50 * 1e18;

	constructor(address oracleAddress_) {
		oracleAddress = oracleAddress_;
		owner = msg.sender;
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

	// function withdraw() {}

	fallback() external payable {
		fund();
	}

	receive() external payable {
		fund();
	}
}