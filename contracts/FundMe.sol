// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

contract FundMe {
	using PriceConverter for uint256;

	function fund() public payable {
		//require(msg.value >= minimumUsd, "Insufficient funds");
	}

	// function withdraw() {}
}