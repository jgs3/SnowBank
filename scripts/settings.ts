import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    feeAddress: "0xD7544E32014F4D0ad77bf5084C8Cbd2321b7a930",
    deployerAddress: "0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893",
    wild: "0xC5BDB5b8f5BDc6eD6251B250C69a20e329d66282",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    weth: "0x4DB5a66E937A9F4473fA95b1cAF1d1E1D62E29EA",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    zapper: "0x449d14e5D2C439a235E28A65CA1744a96355CF93",
    masterchef: "0x6D80e16B6B44D9d69c1fB535326Dee44B06594bA",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);

    const token = await ethers.getContractAt("ThreeWildToken", config.wild);
    // const zapper = await ethers.getContractAt("ThreeWildToken", config.zapper);
    const masterchef = await ethers.getContractAt("MasterChef", config.masterchef);

    // await token.mint(config.feeAddress, ethers.utils.parseEther("5000"));

    // console.log("setting zapper to whitelist...");
    // await token.setProxy(config.zapper);
    // console.log("done");
    // console.log("transferring ownership to masterchef...");
    // await token.transferOwnership(config.masterchef);
    // console.log("done");

    console.log("updating emission...");
    await masterchef.updateEmissionRate("11000000000000000");
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
