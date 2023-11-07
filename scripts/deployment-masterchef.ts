import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    startTime: 1698733996, //Date and time (GMT): Thursday, September 7, 2023 2:22:25 PM
    devAddress: "0xD7544E32014F4D0ad77bf5084C8Cbd2321b7a930",
    feeAddress: "0xD7544E32014F4D0ad77bf5084C8Cbd2321b7a930",
    deployerAddress: '0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893',
    wild: "0xC5BDB5b8f5BDc6eD6251B250C69a20e329d66282",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    usdt: "0x55d398326f99059fF775485246999027B3197955",
    busd: "0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56",
    nft: "0xa07eae08eC9d7Ff5a6E1B626aD7F147D87482667",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const token = await ethers.getContractAt("ThreeWildToken", config.wild);

    const masterChef = await utils.deployAndVerify("MasterChef", [
        token.address,
        config.feeAddress, //dev address
        config.feeAddress, //fee address
        config.startTime,
    ]);
    // await token.transferOwnership(masterChef.address);
    const wildWbnbPair = await factory.getPair(config.wbnb, token.address);
    const webnbUSDCPair = await factory.getPair(config.usdc, config.wbnb);

    // adding new pool
    console.log('adding new pool...');
    await masterChef.add(650, wildWbnbPair, 0, false, false);
    await masterChef.add(0, webnbUSDCPair, 400, false, false);
    await masterChef.add(50, config.nft, 0, false, true);
    await masterChef.add(100, config.wild, 300, false, false);
    await masterChef.add(50, config.wbnb, 500, false, false);
    await masterChef.add(50, config.busd, 500, false, false);
    await masterChef.add(50, config.usdt, 500, false, false);
    await masterChef.add(50, config.usdc, 500, false, false);

    console.log('done');

    console.log({
        token: token.address,
        masterChef: masterChef.address,
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
