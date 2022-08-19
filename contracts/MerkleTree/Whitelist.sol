// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

// All the leaf nodes of the tree, i.e. nodes that don't have any further children,
// include hashes of data that you want to encode. Note that the values you want to
//  encode in the tree are always just part of the leaf nodes. Since it is a
// binary tree, each non-leaf node has two children. As you move up from the leaf nodes,
// the parents will have the hash of the combined hashes of the leaf nodes, and so on.

contract Whitelist {
    bytes32 public merkleRoot;

    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
    }

    function checkInWhitelist(
        bytes32[] calldata proof,
        uint64 maxAllowanceToMint
    ) public view returns (bool) {
        // recreates the leaf by hashing the encoded data it has in the merkle tree
        bytes32 leaf = keccak256(abi.encode(msg.sender, maxAllowanceToMint));
        // given the proof and the leaf, proceeds to verify if it result in the merkle root, in which case it will be verified
        bool verified = MerkleProof.verify(proof, merkleRoot, leaf);
        return verified;
    }
}
