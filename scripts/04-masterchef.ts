import { ethers } from "hardhat";
const utils = require("../scripts/utils");

import { config } from "./config";

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
<<<<<<< HEAD
    const token = await ethers.getContractAt("GEMToken", config.gem);
=======
    const token = await ethers.getContractAt("SnowToken", config.snow);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4

    const masterChef = await utils.deployAndVerify("MasterChef", [
        token.address,
        config.feeAddress, //dev address
        config.feeAddress, //fee address
        config.zap,
        config.startTime,
    ]);
    // await token.transferOwnership(masterChef.address);
<<<<<<< HEAD
    const gemwethPair = await factory.getPair(config.weth, token.address);
=======
    const snowwethPair = await factory.getPair(config.weth, token.address);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
    const wethUSDCPair = await factory.getPair(config.usdc, config.weth);

    // adding new pool
    console.log("adding new pool...");
<<<<<<< HEAD
    await masterChef.add(950, gemwethPair, 100, false, false);
    await masterChef.add(0, wethUSDCPair, 1000, false, false);
    await masterChef.add(50, config.gem, 300, false, false);
    // await masterChef.add(0, config.weth, 300, false, false);
    // await masterChef.add(0, config.nft, 0, false, true);
=======
    await masterChef.add(850, snowwethPair, 100, false, false);
    await masterChef.add(0, wethUSDCPair, 1000, false, false);
    await masterChef.add(150, config.snow, 300, false, false);
    await masterChef.add(0, config.weth, 300, false, false);
    await masterChef.add(0, config.nft, 0, false, true);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4

    console.log("done");

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
