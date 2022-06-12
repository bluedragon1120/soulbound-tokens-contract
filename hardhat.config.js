require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");
require('hardhat-contract-sizer')
require("hardhat-watcher")
require('hardhat-abi-exporter')

require('dotenv').config();

module.exports = {
  abiExporter: {
    path: "./abis",
    clear: true,
    flat: true
  },
  networks: {
    hardhat: {
      allowUnlimitedContractSize: true
    },
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${process.env.INFURA_API_KEY}`,
      chainId: 4,
      accounts: [`${process.env.PRIVATE_KEY}`]
    }
  },
  solidity: {
    version: "0.8.10",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  mocha: {
    timeout: 360000
  },
  etherscan: {
    apiKey: {
      rinkeby: process.env.ETHERSCAN_API_KEY || ""
    }
  },
  watcher: {
    compile: {
      tasks: ["compile"],
      files: ["./contracts"],
      verbose: true,
    }
  }
};