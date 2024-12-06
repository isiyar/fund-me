# FundMe smart-contract

## Description
FundMe is a smart contract that allows users to create crowdfunding campaigns on the blockchain. Users can make cryptocurrency donations to these campaigns. Funds raised by the campaign are stored in the smart contract and can be withdrawn by the campaign creator once the goal is reached.

## Getting Started
1. Dependency installation:

	`npm install`

2. Create an .env file:

	`touch .env`

3. Fill in the file according to the template .env.template

4. Deploy contract:

	`npx hardhat run scripts/deploy.js --network your_network`

4. After executing these commands you will see the address of your smart contract