# About the Project
## Inspiration
The need for transparent and fair random selection processes inspired us to develop a Lottery platform using Chainlink VRF and Upkeep. Our goal is to provide a reliable solution that can be integrated into various applications, ensuring integrity and trust.

## What it does
Our platform utilizes Chainlink VRF to generate provably fair random numbers and Chainlink Upkeep to automate operations like drawing winners and distributing prizes at regular intervals.

## How we built it
We built the platform using Solidity for smart contracts, integrated Chainlink VRF 2.5 for randomness, and Chainlink Upkeep for automation. The testing framework used is Foundry, and the front end can be quickly built using Next.js.

## Challenges we ran into
Integrating Chainlink technologies and optimizing gas usage were significant challenges. However, these hurdles helped us refine our approach and build a more efficient system.

## Accomplishments that we're proud of
Creating a scalable and versatile platform that ensures fairness and transparency in random selections. The system's ability to automate operations and integrate with various applications is a significant achievement.

## What we learned
We gained valuable insights into integrating advanced Chainlink functionalities and optimizing smart contract performance. The project also enhanced our understanding of building scalable and secure decentralized applications.

## What's next for our Lottery Platform
We plan to expand our platform's capabilities by adding multi-chain support and exploring new use cases. Collaborations with other projects and developers will be key to further enhancing our solution.

# Quick Start

1. Clone this repo & install dependencies
```
git clone https://github.com/JarvisChan666/RafVerse.git
cd RafVerse-master
yarn install
foundryup
```

2. Create your `.env` file inside `packages/foundry`:

```
(echo "DEPLOYER_PRIVATE_KEY=";  echo "ALCHEMY_API_KEY=oKxs-03sij-U_N0iOlrSsZFr29-IqbuF"; echo "ETHERSCAN_API_KEY=DNXJA8RX2Q3VZ4URQIWP7Z68CJXQZSC6AW") >> packages/foundry/.env
```

3. Run a local network in the first terminal:

```
yarn chain
```

This command starts a local Ethereum network using Anvil in Foundry. The network runs on your local machine and can be used for testing and development. You can customize the network configuration in `foundry.toml`

4. On a second terminal, deploy the test contract:

```
packages/foundry

forge script script/DeployRaffleNew.s.sol:DeployRaffle --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY --with-gas-price 30gwei --priority-gas-price 20gwei -vvvv
```

This command deploys a test smart contract to the local network. The contract is located in `packages/foundry/src` and can be modified to suit your needs. The `yarn deploy` command uses the deploy script located in `packages/foundry/script/Deploy.s.sol` to deploy the contract to the network. You can also customize the deploy script.

5. On a third terminal, start your NextJS app:

```
yarn start
```
Visit your app on: `http://localhost:3000`. You can interact with your smart contract using the contract component or the example ui in the frontend. You can tweak the app config in `packages/nextjs/scaffold.config.ts`.

6. Interact with our Raffle Contract
cast send 0x6A50a6E69B598620Bfab47C28C2c92Ec5C0C598B "enterRaffle()" --value 0.0001ether --private-key $PRIVATE_KEY --rpc-url $SEPOLIA_RPC_URL

7. TODO. Frontend