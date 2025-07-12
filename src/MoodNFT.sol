//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;
import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract MoodNFT is ERC721, Ownable {
    error MoodNFT__UserHasMintedNFTAlready();
    error MoodNFT__onlyOwnerCanFlipMood();
    error MoodNFT__NotMintedYET();
    enum moodState {
        SAD,
        HAPPY
    }

    mapping(uint256 => moodState) public s_idToState;
    uint256 s_tokenCounter;
    string s_happySVG;
    string s_sadSVG;

    constructor(
        string memory _s_happySVG,
        string memory _s_sadSVG
    ) ERC721("MOODNFT", "MN") Ownable(msg.sender) {
        s_happySVG = _s_happySVG;
        s_sadSVG = _s_sadSVG;
    }

    function mintNFT() external {
        _safeMint(msg.sender, s_tokenCounter);
        s_idToState[s_tokenCounter] = moodState.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 _id) public {
        moodState status = s_idToState[_id];
        if (msg.sender != ownerOf(_id)) {
            revert MoodNFT__onlyOwnerCanFlipMood();
        }
        if (status == moodState.HAPPY) {
            s_idToState[_id] = moodState.SAD;
        } else {
            s_idToState[_id] = moodState.HAPPY;
        }
    }

    function tokenURI(
        uint256 _id
    ) public view override returns (string memory) {
        moodState temp = s_idToState[_id];
        if (_ownerOf(_id) == address(0)) {
            revert MoodNFT__NotMintedYET();
        }
        string memory imgURI = temp == moodState.SAD ? s_sadSVG : s_happySVG;
        string memory moodString = temp == moodState.SAD ? "SAD" : "HAPPY";

        return
            string(
                abi.encodePacked(
                    '{"name":"Mood NFT ',
                    Strings.toString(_id),
                    '",',
                    '"description":"An NFT that reflects the mood of the owner, 100% on Chain!",',
                    '"attributes":[{"trait_type":"Mood","value":"',
                    moodString,
                    '"}],',
                    '"image":"',
                    imgURI,
                    '"}'
                )
            );
    }

    function getMood(uint256 tokenId) external view returns (moodState) {
        return s_idToState[tokenId];
    }
}
