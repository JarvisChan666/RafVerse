// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {VRFCoordinatorV2Mock} from "../test/mocks/VRFCoordinatorV2Mock.sol";
import {LinkToken} from "../test/mocks/LinkToken.sol";
import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        uint256 subscriptionId;
        bytes32 keyHash;
        // bytes32 gasLane;
        uint256 automationUpdateInterval;
        uint256 raffleEntranceFee;
        uint32 callbackGasLimit;
        address vrfCoordinatorV2;
        address link;
        uint256 deployerKey;
    }

    uint256 public DEFAULT_ANVIL_PRIVATE_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    event HelperConfig__CreatedMockVRFCoordinator(address vrfCoordinator);

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 80002) {
            activeNetworkConfig = getAmoyEthConfig();
        }
         else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    // function getMainnetEthConfig()
    //     public
    //     view
    //     returns (NetworkConfig memory mainnetNetworkConfig)
    // {
    //     mainnetNetworkConfig = NetworkConfig({
    //         subscriptionId: 1, // If left as 0, our scripts will create one!
    //         gasLane: 0x9fe0eebf5e446e3c998ec9bb19951541aee00bb90ea201ae456421a2ded86805,
    //         automationUpdateInterval: 30, // 30 seconds
    //         raffleEntranceFee: 0.001 ether,
    //         callbackGasLimit: 500000, // 500,000 gas
    //         vrfCoordinatorV2: 0x271682DEB8C4E0901D1a1550aD2e64D568E69909,
    //         link: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
    //         deployerKey: vm.envUint("PRIVATE_KEY")
    //     });
    // }

    function getSepoliaEthConfig()
        public
        view
        returns (NetworkConfig memory sepoliaNetworkConfig)
    {
        sepoliaNetworkConfig = NetworkConfig({
            keyHash: 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae,
            subscriptionId: 60815715066710352934134236486086509044635862781933132903170206674295115883192, // If left as 0, our scripts will create one!
            // gasLane: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c,
            automationUpdateInterval: 30, // 30 seconds
            raffleEntranceFee: 0.01 ether,
            callbackGasLimit: 500000, // 500,000 gas
            vrfCoordinatorV2: 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B,
            link: 0x779877A7B0D9E8603169DdbD7836e478b4624789,
            deployerKey: vm.envUint("PRIVATE_KEY")
        });
    }

    function getAmoyEthConfig()
        public
        view
        returns (NetworkConfig memory amoyNetworkConfig)
    {
        amoyNetworkConfig = NetworkConfig({
            keyHash: 0x816bedba8a50b294e5cbd47842baf240c2385f2eaf719edbd4f250a137a8c899,
            subscriptionId: 12115010683013893300959619972446265287007342099186146847497823137715683232132, // If left as 0, our scripts will create one!
            automationUpdateInterval: 30, // 30 seconds
            raffleEntranceFee: 0.01 ether,
            callbackGasLimit: 2500000, // 500,000 gas
            vrfCoordinatorV2: 0x343300b5d84D444B2ADc9116FEF1bED02BE49Cf2,
            link: 0x0Fd9e8d3aF1aaee056EB9e802c3A762a667b1904,
            deployerKey: vm.envUint("PRIVATE_KEY")
        });
    }

    function getOrCreateAnvilEthConfig()
        public
        returns (NetworkConfig memory anvilNetworkConfig)
    {
        if (activeNetworkConfig.vrfCoordinatorV2 != address(0)) {
            return activeNetworkConfig;
        }

        uint96 baseFee = 0.25 ether;
        uint96 gasPriceLink = 1e9;

        vm.startBroadcast(DEFAULT_ANVIL_PRIVATE_KEY);
        VRFCoordinatorV2Mock vrfCoordinatorV2Mock = new VRFCoordinatorV2Mock(
            baseFee,
            gasPriceLink
        );

        LinkToken link = new LinkToken();
        vm.stopBroadcast();

        emit HelperConfig__CreatedMockVRFCoordinator(
            address(vrfCoordinatorV2Mock)
        );

        anvilNetworkConfig = NetworkConfig({
            subscriptionId: 0, // If left as 0, our scripts will create one!
            // gasLane: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c, // doesn't really matter
            keyHash: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c,
            automationUpdateInterval: 30, // 30 seconds
            raffleEntranceFee: 0.01 ether,
            callbackGasLimit: 500000, // 500,000 gas
            vrfCoordinatorV2: address(vrfCoordinatorV2Mock),
            link: address(link),
            deployerKey: DEFAULT_ANVIL_PRIVATE_KEY
        });
    }
}
