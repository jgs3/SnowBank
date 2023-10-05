import { HardhatUserConfig } from "hardhat/config";
import "hardhat-deploy";
import "@nomicfoundation/hardhat-chai-matchers";
import "@nomiclabs/hardhat-ethers";
import "@nomiclabs/hardhat-etherscan";
import "solidity-coverage";
import "solidity-coverage";
// import "hardhat-contract-sizer";
import "hardhat-gas-reporter";
import "hardhat-abi-exporter";
import "hardhat-spdx-license-identifier";
import "hardhat-tracer";
import "solidity-docgen";

const config = require("./config.js");

module.exports = {
    networks: {
        hardhat: {
            forking: {
                enabled: true,
                url: "https://base-mainnet.diamondswap.org/rpc",
                //blockNumber: 17130449

                // If using blockNumber, RPC node should be archive
            },
        },
        "base-mainnet": {
            url: "https://base-mainnet.diamondswap.org/rpc",
            accounts: config.mainnetAccounts,
            // gasPrice: 1000000000,
        },
        // for testnet
        "base-goerli": {
            url: "https://goerli.base.org",
            accounts: config.mainnetAccounts,
            // gasPrice: 1000000000,
        },
        "base-devnet": {
            url: "https://rpc.vnet.tenderly.co/devnet/base-devnet/b209b556-47d7-4727-a935-aad569bc879c",
            accounts: config.mainnetAccounts,
        },
        localhost: {
            url: "http://127.0.0.1:8545",
        },
    },
    etherscan: {
        apiKey: {
            "base-goerli": config.apiKeyBase,
            "base-mainnet": config.apiKeyBase,
        },
        customChains: [
            {
                network: "base-goerli",
                chainId: 84531,
                urls: {
                    apiURL: "https://api-goerli.basescan.org/api",
                    browserURL: "https://goerli.basescan.org",
                },
            },
            {
                network: "base-mainnet",
                chainId: 8453,
                urls: {
                    apiURL: "https://api.basescan.org/api",
                    browserURL: "https://basescan.org",
                },
            },
        ],
    },
    namedAccounts: {
        deployer: 0,
    },
    solidity: {
        compilers: [
            {
                version: "0.8.15",
                settings: {
                    optimizer: {
                        enabled: true,
                        runs: 200,
                    },
                },
            },
            {
                version: "0.5.16",
            },
            {
                version: "0.6.6",
            },
            {
                version: "0.6.12",
                settings: {
                    optimizer: {
                        enabled: true,
                        runs: 200,
                    },
                },
            },
        ],
    },
    mocha: {
        timeout: 100000,
    },
    // docs: https://www.npmjs.com/package/hardhat-contract-sizer
    contractSizer: {
        alphaSort: true,
        runOnCompile: true,
        disambiguatePaths: false,
        except: ["echidna-test/", "test/", "pancakeSwap/", "@openzeppelin/contracts/"],
    },
    // docs: https://www.npmjs.com/package/hardhat-gas-reporter
    gasReporter: {
        currency: "USD",
        token: "BNB", // ETH, BNB, MATIC, AVAX, HT, MOVR
        coinmarketcap: config.coinmarketcapApi,
        excludeContracts: ["echidna-test/", "pancakeSwap/", "test/", "@openzeppelin/contracts/"],
    },
    // docs: https://www.npmjs.com/package/hardhat-abi-exporter
    abiExporter: {
        path: "./data/abi",
        runOnCompile: true,
        clear: true,
        flat: true,
        spacing: 2,
        except: [],
    },
    spdxLicenseIdentifier: {
        overwrite: true,
        runOnCompile: true,
    },
    // docs: https://www.npmjs.com/package/solidity-docgen
    // config info: https://github.com/OpenZeppelin/solidity-docgen/blob/master/src/config.ts
    docgen: {
        pages: "items",
        exclude: [
            "RfiToken.sol",
            "test/",
            "pancakeSwap/",
            "echidna-test/",
            "@openzeppelin/contracts/",
        ],
    },
} as HardhatUserConfig;
