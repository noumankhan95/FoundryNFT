//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {DeployMoodNFT} from "script/DeployMoodNFT.s.sol";
import {MoodNFT} from "src/MoodNFT.sol";

contract TestMoodNFT is Test {
    MoodNFT internal moodnft;
    DeployMoodNFT internal deployMoodNFT;

    function setUp() external {
        deployMoodNFT = new DeployMoodNFT();
        moodnft = deployMoodNFT.run();
    }
}
