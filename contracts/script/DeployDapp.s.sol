//SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {History} from "../lib/rollups-contracts/onchain/rollups/contracts/history/History.sol";
import {CartesiDApp} from "../lib/rollups-contracts/onchain/rollups/contracts/dapp/CartesiDApp.sol";
import {Authority} from "../lib/rollups-contracts/onchain/rollups/contracts/consensus/authority/Authority.sol";
import {ISelfHostedApplicationFactory} from "../lib/rollups-contracts/onchain/rollups/contracts/dapp/ISelfHostedApplicationFactory.sol";

contract DeployDapp is Script {
    ISelfHostedApplicationFactory public factory;

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        factory = ISelfHostedApplicationFactory(0x9E32e06Fd23675b2DF8eA8e6b0A25c3DF6a60AbC); // change after filecoin deploy
        (CartesiDApp dapp, Authority authority, History history) = factory.deployContracts(
            vm.envAddress("AUTHORITY_OWNER_ADDRESS"),
            vm.envAddress("DAPP_OWNER_ADDRESS"),
            vm.envBytes32("TEMPLATE_HASH"),
            bytes32(abi.encode(1596))
        );
        console.log(
            "Dapp address:",
            address(dapp)
        );
        console.log(
            "Authority address:",
            address(authority)
        );
        console.log(
            "History address:",
            address(history)
        );
        console.log("All deploys performed successfully at chain id:", block.chainid);
        vm.stopBroadcast();
    }
}
