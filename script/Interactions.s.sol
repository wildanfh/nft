// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "src/BasicNft.sol";

contract MintBasicNft is Script {
  string public constant PUG = "ipfs://QmYXqTGDFSpovvtYiuodfdUsfbEtP89Ss8KDbZUuVW4Pw8";

  function run() external {
    address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
    mintNftOnContract(mostRecentlyDeployed);
  }

  function mintNftOnContract(address contractAddress) public {
    vm.startBroadcast();
    BasicNft(contractAddress).mintNft(PUG);
    vm.stopBroadcast();
  }
}