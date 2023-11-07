import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    feeAddress: "0xD7544E32014F4D0ad77bf5084C8Cbd2321b7a930",
    deployerAddress: '0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893',
    wild: "0xE9f49BE8C684A823102b33DA0cEa82c6e229F05C",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    weth: "0x4DB5a66E937A9F4473fA95b1cAF1d1E1D62E29EA",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    zapper: "0x8C0Df30e63135eC82bBE0ABb8B28fEE078bAbc50",
    masterchef: "0x2b2Ed985F0F6C5EB1B1942e53c24E060fE43537b"
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const token = await utils.deployAndVerify("ThreeWildToken", [config.router]);

    await token.mint(config.deployerAddress, ethers.utils.parseEther("5000"));

    const wildWbnbPair = await factory.getPair(config.wbnb, token.address);
    const usdcWethPair = await factory.getPair(config.usdc, config.wbnb);

    console.log({
        token: token.address,
        wildWbnbPair: wildWbnbPair,
        usdcWethPair: usdcWethPair,
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
