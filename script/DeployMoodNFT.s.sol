//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    function run() external returns (MoodNFT moodNFT) {
        string memory sadSVG = vm.readFile("./images/sad.svg");
        string memory happySVG = vm.readFile("./images/happy.svg");
        moodNFT = new MoodNFT(
            convertImgToBase64(happySVG),
            convertImgToBase64(sadSVG)
        );
    }

    function convertImgToBase64(
        string memory svg
    ) internal returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgbase64 = Base64.encode(abi.encodePacked(svg));
        return string(abi.encodePacked(baseURI, svgbase64));
    }
}
