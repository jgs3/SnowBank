import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0x3E84D913803b02A4a7f027165E8cA42C14C0FdE7",
    router: "0x8c1A3cF8f83074169FE5D7aD50B978e1cD6b37c7",
    startTime: 1694096545, //Date and time (GMT): Thursday, September 7, 2023 2:22:25 PM
    devAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    feeAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    masterChefAddress: "0x58f5F2AD3cfC3690B026170c7E3BE0582BE5148A",
    wild: "0x3Bd80f5c62784D4a31e312E2801025E8c0b3Ad1f",
    usdc: "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA",
    weth: "0x4200000000000000000000000000000000000006",
    dai: "0x50c5725949A6F0c72E6C4a641F24049A917DB0Cb",
    mim: "0x4A3A6Dd60A34bB2Aba60D73B4C88315E9CeB6A3D",
    alb: "0x1dd2d631c92b1aCdFCDd51A0F7145A50130050C4",
    sushi: "0x81aB7E0D570b01411fcC4afd3D50eC8C241cb74b",
    uni: "0x1dd2d631c92b1aCdFCDd51A0F7145A50130050C4",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);

    const wildAlbPair = await factory.getPair(config.alb, config.wild);
    const wildSushiPair = await factory.getPair(config.sushi, config.wild);
    const wildUniPair = await factory.getPair(config.uni, config.wild);
    console.log({
        wildAlbPair: wildAlbPair,
        wildSushiPair: wildSushiPair,
        wildUniPair: wildUniPair,
    });
    const masterChef = await ethers.getContractAt("WildMasterChef", config.masterChefAddress);
    // await masterChef.add(500, lfgWethPair, 100, false, false);
    // await masterChef.add(250, usdcWethPair, 300, false, false);
    await masterChef.add(80, wildAlbPair, 200, false, false);
    await masterChef.add(80, wildSushiPair, 200, false, false);
    await masterChef.add(80, wildUniPair, 200, false, false);

    const wildEthPool = {
        pid: 3,
        allocation: 200,
        depositFee: 200,
        withDepositDiscount: true,
    };
    const wildDaiPool = {
        pid: 3,
        allocation: 120,
        depositFee: 200,
        withDepositDiscount: true,
    };
    const wildUsdcPool = {
        pid: 3,
        allocation: 120,
        depositFee: 200,
        withDepositDiscount: true,
    };
    const wildMimPool = {
        pid: 3,
        allocation: 120,
        depositFee: 200,
        withDepositDiscount: true,
    };
    await setPool(masterChef, wildEthPool, true);
    await setPool(masterChef, wildDaiPool, true);
    await setPool(masterChef, wildUsdcPool, true);
    await setPool(masterChef, wildMimPool, true);

    console.log("done");
}

async function setPool(masterChef: any, poolConfig: any, withUpdate = false) {
    console.log(`setting pool ${poolConfig.name}`);
    await masterChef.set(
        poolConfig.pid,
        poolConfig.allocation,
        poolConfig.depositFee,
        withUpdate,
        poolConfig.withDepositDiscount
    );
    console.log(`pool set\n`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
