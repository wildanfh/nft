// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
  mapping(uint256 => string) private sTokenIdToUri;
  uint256 private sTokenCounter;

  constructor() ERC721("Dogie", "DOG") {
    sTokenCounter = 0;
  }

  function mintNft(string memory tokenUri) public {
    sTokenIdToUri[sTokenCounter] = tokenUri;
    _safeMint(msg.sender, sTokenCounter);
    sTokenCounter++;
  }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    return sTokenIdToUri[tokenId];
    // "https://ipfs.tech/ipfs/QmYXqTGDFSpovvtYiuodfdUsfbEtP89Ss8KDbZUuVW4Pw8"
  }
}