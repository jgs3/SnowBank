import { ethers } from "hardhat";
const utils = require("../scripts/utils");

import { config } from "./config";

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
<<<<<<< HEAD
    const token = await utils.deployAndVerify("GEMToken", [config.router]);
=======
    const token = await utils.deployAndVerify("SnowToken", []);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4

    await token.mint(config.devAddress, ethers.utils.parseEther("5000"));
    // await token.mint(config.deployerAddress, ethers.utils.parseEther("100"));

    // const snowwethPair = await factory.getPair(config.weth, token.address);

    console.log({
        token: token.address,
        // snowwethPair: snowwethPair,
        // usdcWethPair: usdcWethPair,
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
