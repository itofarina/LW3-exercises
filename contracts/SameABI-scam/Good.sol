//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./Helper.sol";

// Notice that Attack.sol has the same ABI as Helper.sol
// a malicious user can deploy Good contract with an address pointing to this type of Attack contract
// PREVENTION:
// 1) make external contract address public and verify external contract so that all users can view the code
// 2) declare new instance in constructor Helper helper = new Helper()
// From the site: Create a new contract, instead of typecasting an address into a contract inside the constructor. So instead of doing Helper(_helper) where you are typecasting _helper address into a contract which may or may not be the Helper contract, create an explicit new helper contract instance using new Helper().
contract Good {
    Helper helper;

    constructor(address _helper) payable {
        helper = Helper(_helper);
    }

    function isUserEligible() public view returns (bool) {
        return helper.isUserEligible(msg.sender);
    }

    function addUserToList() public {
        helper.setUserEligible(msg.sender);
    }

    fallback() external {}
}
