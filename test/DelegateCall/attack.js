const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Delegate call Attack", function () {
  it("Should change the owner of the Good contract", async function () {
    // Deploy the helper contract
    const helperContract = await ethers.getContractFactory("contracts/DelegateCall/Helper.sol:Helper");
    const _helperContract = await helperContract.deploy();
    await _helperContract.deployed();
    console.log("Helper Contract's Address:", _helperContract.address);

    // Deploy the good contract
    const goodContract = await ethers.getContractFactory("contracts/DelegateCall/Good.sol:Good");
    const _goodContract = await goodContract.deploy(_helperContract.address);
    await _goodContract.deployed();
    console.log("Good Contract's Address:", _goodContract.address);

    // Deploy the Attack contract
    const attackContract = await ethers.getContractFactory(
      "contracts/DelegateCall/Attack.sol:Attack"
    );
    const _attackContract = await attackContract.deploy(_goodContract.address);
    await _attackContract.deployed();
    console.log("Attack Contract's Address", _attackContract.address);

    // Now lets attack the good contract

    // Start the attack
    let tx = await _attackContract.attack();
    await tx.wait();

    expect(await _goodContract.owner()).to.equal(_attackContract.address);
  });
});
