import { ethers } from "hardhat";
const utils = require("../scripts/utils");
const { config } = require("../scripts/config")


async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const token = await ethers.getContractAt("PWildToken", config.wild);

    const masterChef = await utils.deployAndVerify("MasterChef", [
        token.address,
        config.feeAddress, //dev address
        config.feeAddress, //fee address
        config.zapper,
        config.startTime,
    ]);
    // await token.transferOwnership(masterChef.address);
    const wildWplsPair = await factory.getPair(config.wpls, token.address);
    const wplsUSDCPair = await factory.getPair(config.usdc, config.wpls);

    // adding new pool
    console.log('adding new pool...');
    await masterChef.add(700, wildWplsPair, 0, false, false);
    await masterChef.add(0, wplsUSDCPair, 900, false, false);
    await masterChef.add(100, config.wpls, 600, false, false);
    await masterChef.add(50, config.dai, 500, false, false);
    await masterChef.add(50, config.usdc, 400, false, false);
    await masterChef.add(50, config.usdt, 400, false, false);
    await masterChef.add(50, config.nft, 0, false, true);
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
