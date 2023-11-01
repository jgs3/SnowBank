import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    feeAddress: "0xD7544E32014F4D0ad77bf5084C8Cbd2321b7a930",
    deployerAddress: "0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893",
    wild: "0xE9f49BE8C684A823102b33DA0cEa82c6e229F05C",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    weth: "0x4DB5a66E937A9F4473fA95b1cAF1d1E1D62E29EA",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    zapper: "0x8C0Df30e63135eC82bBE0ABb8B28fEE078bAbc50",
    masterchef: "0x2b2Ed985F0F6C5EB1B1942e53c24E060fE43537b",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);

    const token = await ethers.getContractAt("ThreeWildToken", config.wild);
    // const zapper = await ethers.getContractAt("ThreeWildToken", config.zapper);
    const masterchef = await ethers.getContractAt("ThreeWildToken", config.masterchef);


    // await token.mint(config.feeAddress, ethers.utils.parseEther("5000"));

    // console.log("setting zapper to whitelist...");
    // await token.setProxy(config.zapper);
    // console.log("done");
    console.log("transferring ownership to masterchef...");
    await token.transferOwnership(config.masterchef);
    console.log("done");

    // console.log("transferring ownership of masterchef...");
    // await masterchef.transferOwnership(config.feeAddress);
    // console.log("done");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
