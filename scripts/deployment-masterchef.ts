import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0x29eA7545DEf87022BAdc76323F373EA1e707C523",
    router: "0x165C3410fC91EF562C50559f7d2289fEbed552d9",
    startTime: 1698733996, //Date and time (GMT): Thursday, September 7, 2023 2:22:25 PM
    devAddress: "0x41140Df415A2898937d147842C314c70B3aab82E",
    feeAddress: "0x41140Df415A2898937d147842C314c70B3aab82E",
    deployerAddress: '0x41140Df415A2898937d147842C314c70B3aab82E',
    wild: "0x058698C5Fd5925dA0cE03D3B1803C0146e734fF8",
    usdc: "0x15D38573d2feeb82e7ad5187aB8c1D52810B1f07",
    wpls: "0xA1077a294dDE1B09bB078844df40758a5D0f9a27",
    usdt: "0x0Cb6F5a34ad42ec934882A05265A7d5F59b51A2f",
    dai: "0xefD766cCb38EaF1dfd701853BFCe31359239F305",
    nft: "0xE6f089D0403a39D21DC0892b42bb8B2F249CeDe3",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const token = await ethers.getContractAt("PWildToken", config.wild);

    const masterChef = await utils.deployAndVerify("MasterChef", [
        token.address,
        config.feeAddress, //dev address
        config.feeAddress, //fee address
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
