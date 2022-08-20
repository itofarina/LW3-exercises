require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });
require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");

const ALCHEMY_API_KEY_URL = process.env.ALCHEMY_API_KEY_URL; // for polygon mainnet
const GOERLI_ALCHEMY_API_KEY_URL = process.env.GOERLI_ALCHEMY_API_KEY_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const GOERLI_ALCHEMY_API_KEY = process.env.GOERLI_ALCHEMY_API_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers: [{ version: "0.8.9", version: "0.8.10" }],
  },
  networks: {
    hardhat: {
      // forking: {
      //   url: ALCHEMY_API_KEY_URL,
      // },
    },
    goerli: {
      url: GOERLI_ALCHEMY_API_KEY_URL,
      accounts: [PRIVATE_KEY],
    },
  },
};
