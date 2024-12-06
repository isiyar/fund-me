const { ethers } = require("hardhat");
require("dotenv").config();

async function main() {
	const FundMe = await ethers.getContractFactory("FundMe");
	const contract = await FundMe.deploy(
		process.env.CHAINLINK_ORACLE_ADDRESS,
		process.env.MINIMUM_USD
	);
	await contract.waitForDeployment();

	console.log("Contract deployed to address:", contract.target);
}

main()
	.then(() => process.exit(0))
	.catch(error => {
		console.error(error);
		process.exit(1);
	});
