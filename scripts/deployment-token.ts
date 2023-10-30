import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    feeAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    deployerAddress: '0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893',
    wild: "0xEE24730A00943A16A2C4c84055eFbc14a6E51220",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    weth: "0x4DB5a66E937A9F4473fA95b1cAF1d1E1D62E29EA",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    zapper: "0xE102A51014b3FFb69E7Be5d8d0a13510A0b93b56",
    masterchef: "0xD0e9181148C1f0F8653d8b8FF8a4f286BA6E4066"
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    // const token = await utils.deployAndVerify("WildToken", [config.router]);

    // await token.mint(config.deployerAddress, ethers.utils.parseEther("500000"));

    // const wildWbnbPair = await factory.getPair(config.wbnb, token.address);
    // const usdcWethPair = await factory.getPair(config.usdc, config.wbnb);

    // console.log({
    //     token: token.address,
    //     wildWbnbPair: wildWbnbPair,
    //     usdcWethPair: usdcWethPair,
    // });
    const token = await ethers.getContractAt("WildToken", config.wild);
    console.log('setting zapper to whitelist...');
    await token.setProxy(config.zapper);
    console.log('done')
    console.log('transferring ownership to masterchef...');
    await token.transferOwnership(config.masterchef);
    console.log('done')
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
