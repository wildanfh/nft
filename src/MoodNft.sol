// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    // errors
    error MoodNft__CantFlipMoodIfNotOwner();

    uint256 private sTokenCounter;
    string private sSadSvgImageUri;
    string private sHappySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private sTokenIdToMood;

    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("MoodNft", "MN") {
        sTokenCounter = 0;
        sSadSvgImageUri = sadSvgImageUri;
        sHappySvgImageUri = happySvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, sTokenCounter);
        sTokenIdToMood[sTokenCounter] = Mood.HAPPY;
        sTokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        // only want the NFT owner to be able to change the mood
        if (getApproved(tokenId) != msg.sender) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if (sTokenIdToMood[tokenId] == Mood.HAPPY) {
            sTokenIdToMood[tokenId] = Mood.SAD;
        } else {
            sTokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI = sTokenIdToMood[tokenId] == Mood.HAPPY
            ? sHappySvgImageUri
            : sSadSvgImageUri;

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description": "An NFT that reflects the owner mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                                imageURI,
                                '" }'
                            )
                        )
                    )
                )
            );
    }
}
