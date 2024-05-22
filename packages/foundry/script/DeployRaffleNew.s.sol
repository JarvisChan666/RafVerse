// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfigNew.s.sol";
import {Raffle} from "../contracts/RaffleNew.sol";
// import {AddConsumer, CreateSubscription, FundSubscription} from "./InteractionsNew.s.sol";
// import {AddConsumer} from "./InteractionsNew.s.sol";

contract DeployRaffle is Script {
    function run() external returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        // AddConsumer addConsumer = new AddConsumer();
        (
            uint256 subscriptionId,
            bytes32 keyHash,
            uint256 automationUpdateInterval,
            uint256 raffleEntranceFee,
            uint32 callbackGasLimit,
            address vrfCoordinatorV2,
            address link,
            uint256 deployerKey
        ) = helperConfig.activeNetworkConfig();

        // User don't provide id in helperConfig.
        // if (subscriptionId == 0) {
        //     CreateSubscription createSubscription = new CreateSubscription();
        //     (subscriptionId, vrfCoordinatorV2) = createSubscription
        //         .createSubscription(vrfCoordinatorV2, deployerKey);

        //     FundSubscription fundSubscription = new FundSubscription();
        //     fundSubscription.fundSubscription(
        //         vrfCoordinatorV2,
        //         subscriptionId,
        //         link,
        //         deployerKey
        //     );
        // }

        // Set a custom gas price
        // uint256 customGasPrice = 50 gwei;

        vm.startBroadcast(deployerKey);
        Raffle raffle = new Raffle(
            subscriptionId,
            keyHash,
            automationUpdateInterval,
            raffleEntranceFee,
            callbackGasLimit,
            vrfCoordinatorV2
        );
        vm.stopBroadcast();
        return (raffle, helperConfig);
    }
}
