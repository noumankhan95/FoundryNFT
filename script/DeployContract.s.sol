//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {MyNFT} from "../src/NFTContract.sol";

contract DeployBasicNFT is Script {
    address internal constant OWNER =
        0x1234567890123456789012345678901234567890; // Replace with actual owner address

    function run() external returns (MyNFT myNFT) {
        vm.startBroadcast(OWNER);
        myNFT = new MyNFT();
        vm.stopBroadcast();
        return myNFT;
    }
}
