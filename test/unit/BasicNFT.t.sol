//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../../script/DeployContract.s.sol";
import {MyNFT} from "../../src/NFTContract.sol";
import {console} from "forge-std/console.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployBasicNFT;
    MyNFT public myNFT;
    address internal TestUser = makeAddr("TestUser");
    address internal constant OWNER =
        0x1234567890123456789012345678901234567890; // Replace with actual owner address

    function setUp() external {
        vm.prank(OWNER);
        deployBasicNFT = new DeployBasicNFT();
        myNFT = deployBasicNFT.run();
        vm.deal(OWNER, 100 ether); // Give OWNER some ether for testing
        vm.deal(TestUser, 100 ether); // Give TestUser some ether for testing
    }

    function testDeployContractOwner() external {
        console.log(myNFT.owner());
        assertEq(myNFT.owner(), OWNER, "Owner should match");
    }

    function testCanMintNft() external {
        vm.startPrank(TestUser);
        myNFT.mintNFT(TestUser);
        vm.stopPrank();
        console.log(myNFT.ownerOf(0));
        assertEq(
            myNFT.ownerOf(0),
            TestUser,
            "TestUser should own the minted NFT"
        );
    }

    function testBaseURI() external {
        string memory base = "https://example.com/token/";
        myNFT.mintNFT(TestUser);
        assertEq(
            myNFT.getTokenURI(0),
            string(abi.encodePacked(base, "0")),
            "Token URI should match base URI"
        );
    }
}
