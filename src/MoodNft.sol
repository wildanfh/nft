// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MoodNft is ERC721 {
  uint256 private sTokenCounter;
  string private sSadSvg;
  string private sHappySvg;
    constructor(
        string memory sadSvg,
        string memory happySvg
    ) ERC721("MoodNft", "MN") {
        sTokenCounter = 0;
        sSadSvg = sadSvg;
        sHappySvg = happySvg;
    }

    function mintNft() public {
        _safeMint(msg.sender, sTokenCounter);
        sTokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
    }
}
