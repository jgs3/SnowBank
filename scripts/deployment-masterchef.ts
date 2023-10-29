import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    startTime: 1698598234, //Date and time (GMT): Thursday, September 7, 2023 2:22:25 PM
    devAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    feeAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    deployerAddress: '0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893',
    wild: "0xd413E20a693821A1A6e49384B7Db6Bde22d2c492",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    weth: "0x4DB5a66E937A9F4473fA95b1cAF1d1E1D62E29EA",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    nft: "0x1B7059F151b114E1176Ba409f91A102B07E2C092",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const token = await ethers.getContractAt("WildToken", config.wild);

    const masterChef = await utils.deployAndVerify("MasterChef", [
        token.address,
        config.deployerAddress, //dev address
        config.deployerAddress, //fee address
        config.startTime,
    ]);
    // await token.transferOwnership(masterChef.address);
    const wildWethPair = await factory.getPair(config.weth, token.address);
    const wethUSDCPair = await factory.getPair(config.usdc, config.weth);

    // adding new pool
    console.log('adding new pool...');
    await masterChef.add(980, wildWethPair, 0, false, false);
    await masterChef.add(20, wildWethPair, 0, false, true);
    await masterChef.add(0, wethUSDCPair, 400, false, false);

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
