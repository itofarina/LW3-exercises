//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/**
 * This is a pretty basic contract which stores the address of the last highest bidder, and the value that they bid.
 * Anyone can call setCurrentAuctionPrice and send more ETH than currentAuctionPrice,
 * which will first attempt to send the last bidder their ETH back,
 * and then set the transaction caller as the new highest bidder with their ETH value.
 */
contract Good {
    address public currentWinner;
    uint public currentAuctionPrice;

    constructor() {
        currentWinner = msg.sender;
    }

    function setCurrentAuctionPrice() public payable {
        require(
            msg.value > currentAuctionPrice,
            "Need to pay more than the currentAuctionPrice"
        );
        (bool sent, ) = currentWinner.call{value: currentAuctionPrice}("");

        if (sent) {
            currentAuctionPrice = msg.value;
            currentWinner = msg.sender;
        }
    }
}
