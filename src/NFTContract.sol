//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    error MyNFT__ZeroAddress();
    uint256 public s_tokenCounter = 0;
    mapping(uint256 => string) public s_tokenURI;

    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {}

    function mintNFT(address recepient) external {
        require(recepient != address(0), "MyNFT__ZeroAddress");
        _safeMint(recepient, s_tokenCounter);
        s_tokenURI[s_tokenCounter] = tokenURI(s_tokenCounter);
        s_tokenCounter++;
    }

    function TransferNFT(address from, address to, uint256 tokenID) external {
        transferFrom(from, to, tokenID);
    }

    function getTokenURI(
        uint256 tokenId
    ) external view returns (string memory) {
        return s_tokenURI[tokenId];
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://example.com/token/";
    }
}
