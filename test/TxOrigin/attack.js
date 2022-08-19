const { expect } = require("chai");
const { ethers } = require("hardhat");

/**
 * The attack will happen as follows, initially addr1 will deploy Good.sol and will be the owner but the attacker will somehow fool the user who has the private key of addr1 to call the attack function with Attack.sol.
When the user calls attack function with addr1, tx.origin is set to addr1. attack function further calls setOwner function of Good.sol which first checks if tx.origin is indeed the owner which is true because the original transaction was indeed called by addr1. After verifying the owner, it sets the owner to Attack.sol
And thus attacker is successfully able to change the owner of Good.sol 🤯
 */
describe("Attack", function () {
  it("Attack.sol will be able to change the owner of Good.sol", async function () {
    // Get one address
    const [_, addr1] = await ethers.getSigners();

    // Deploy the good contract
    const goodContract = await ethers.getContractFactory("contracts/TxOrigin/Good.sol:Good");
    const _goodContract = await goodContract.connect(addr1).deploy();
    await _goodContract.deployed();
    console.log("Good Contract's Address:", _goodContract.address);

    // Deploy the Attack contract
    const attackContract = await ethers.getContractFactory("contracts/TxOrigin/Attack.sol:Attack");
    const _attackContract = await attackContract.deploy(_goodContract.address);
    await _attackContract.deployed();
    console.log("Attack Contract's Address", _attackContract.address);

    let tx = await _attackContract.connect(addr1).attack();
    await tx.wait();

    // Now lets check if the current owner of Good.sol is actually Attack.sol
    expect(await _goodContract.owner()).to.equal(_attackContract.address);
  });
});
