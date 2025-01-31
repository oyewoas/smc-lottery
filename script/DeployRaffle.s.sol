// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Raffle} from "src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "./Interactions.s.sol";

contract DeployRaffle is Script {
    function deployContract() public returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        // Get the network configuration
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();
        if (config.subscriptionId == 0) {
            // create subscription
            CreateSubscription createSubscription = new CreateSubscription();
            (config.subscriptionId, config.vrfCoordinator) =
                createSubscription.createSubscription(config.vrfCoordinator, config.account);

            // Fund the contract with LINK
            FundSubscription fundSubscription = new FundSubscription();
            fundSubscription.fundSubscription(config.vrfCoordinator, config.subscriptionId, config.link, config.account);
            helperConfig.setConfig(block.chainid, config);
        }
        vm.startBroadcast(config.account);
        Raffle raffle = new Raffle(
            config.entranceFee,
            config.interval,
            config.vrfCoordinator,
            config.gasLane,
            config.subscriptionId,
            config.callbackGasLimit
        );
        vm.stopBroadcast();

        // Add the contract as a consumer
        AddConsumer addConsumer = new AddConsumer();
        // add consumer already broadcast
        addConsumer.addConsumer(address(raffle), config.vrfCoordinator, config.subscriptionId, config.account);
        return (raffle, helperConfig);
    }

    function run() external returns (Raffle, HelperConfig) {
        return deployContract();
    }
}
