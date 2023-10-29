import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    feeAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    deployerAddress: '0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893',
    wild: "0xd413E20a693821A1A6e49384B7Db6Bde22d2c492",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    weth: "0x4DB5a66E937A9F4473fA95b1cAF1d1E1D62E29EA",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const token = await utils.deployAndVerify("WildToken", [config.weth, config.router]);
    // const token = await ethers.getContractAt("WildToken", config.wild);

    await token.mint(config.deployerAddress, ethers.utils.parseEther("500000"));

    const wildWethPair = await factory.getPair(config.weth, token.address);
    const usdcWethPair = await factory.getPair(config.usdc, token.address);

    console.log({
        token: token.address,
        wildWethPair: wildWethPair,
        wethUSDCPair: usdcWethPair
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
