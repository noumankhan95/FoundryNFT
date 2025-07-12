//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {DeployMoodNFT} from "script/DeployMoodNFT.s.sol";
import {MoodNFT} from "src/MoodNFT.sol";
import {console} from "forge-std/console.sol";

contract TestMoodNFT is Test {
    MoodNFT internal moodnft;
    DeployMoodNFT internal deployMoodNFT;
    string constant NFT_NAME = "MOODNFT";
    address public USER = makeAddr("user");

    function setUp() external {
        deployMoodNFT = new DeployMoodNFT();
        moodnft = deployMoodNFT.run();
    }

    function testInitializedCorrectly() external {
        assertEq(abi.encodePacked(NFT_NAME), abi.encodePacked(moodnft.name()));
    }

    function testUserCanMint() external {
        vm.prank(USER);
        moodnft.mintNFT();

        assertEq(moodnft.balanceOf(USER), 1);
    }

    function testmoodisHappy() external {
        vm.startPrank(USER);
        moodnft.mintNFT();
        vm.stopPrank();
        assertEq(uint256(moodnft.s_idToState(0)), uint256(moodnft.getMood(0)));
    }

    function testOwnerCanFlipMood() external {
        vm.startPrank(USER);
        moodnft.mintNFT();
        moodnft.flipMood(0);
        vm.stopPrank();
        assertEq(uint256(moodnft.s_idToState(0)), uint256(moodnft.getMood(1)));
    }

    function testGetTokenURI() external {
        vm.startPrank(USER);
        moodnft.mintNFT();
        moodnft.flipMood(0);
        string memory uri = moodnft.tokenURI(0);
        console.log(uri);
        vm.stopPrank();
        assertEq(uint256(moodnft.s_idToState(0)), uint256(moodnft.getMood(1)));
    }
}
