// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
	function getPrice(address _oracleAddress) internal view returns (uint256) {
		AggregatorV3Interface dataFeed = AggregatorV3Interface(_oracleAddress);
		(,int256 answer,,,) = dataFeed.latestRoundData();
		return uint256(answer * 1e10);
	}

	function getConversionRate(uint256 ethAmount, address oracleAddress_) internal view returns (uint256) {
		uint256 ethPrice = getPrice(oracleAddress_);
		uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
		return ethAmountInUsd;
	}
}