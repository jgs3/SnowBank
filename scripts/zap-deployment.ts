import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E",
    router: "0x8cFe327CEc66d1C090Dd72bd0FF11d690C33a2Eb",
    startBlock: 4660000, //Date and time (GMT): Thursday, September 7, 2023 2:22:25 PM
    devAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    feeAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    deployerAddress: "0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893",
    masterChefAddress: "0x5D308B84aFa92117A1650b1BeeA6F4BAD2AD3e7b",
    wild: "0xbCDa0bD6Cd83558DFb0EeC9153eD9C9cfa87782E",
    usdc: "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",
    weth: "0x4200000000000000000000000000000000000006",
    dai: "0x50c5725949A6F0c72E6C4a641F24049A917DB0Cb",
    mim: "0x4A3A6Dd60A34bB2Aba60D73B4C88315E9CeB6A3D",
    alb: "0x1dd2d631c92b1aCdFCDd51A0F7145A50130050C4",
    sushi: "0x81aB7E0D570b01411fcC4afd3D50eC8C241cb74b",
    uni: "0x1dd2d631c92b1aCdFCDd51A0F7145A50130050C4",
    baseLp: "0xB775272E537cc670C65DC852908aD47015244EaF",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const router = await ethers.getContractAt("PancakeRouter", config.router);

    const token = await ethers.getContractAt("WILDX", config.wild);
    const wildWethPair = await factory.getPair(config.weth, token.address);

    const zapper = await utils.deployAndVerify("ZapV3");

    await zapper.setCoreValues(
        config.router,
        token.address,
        wildWethPair,
        config.weth
    );
    await zapper.setSwapPath(config.weth, token.address, [config.weth, token.address]);
    await zapper.setSwapPath(token.address, config.weth, [token.address, config.weth]);

    console.log({
        // token: token.address,
        // masterChef: masterChef.address,
        zapper: zapper.address,
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
