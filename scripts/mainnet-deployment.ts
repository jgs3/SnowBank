import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0x3E84D913803b02A4a7f027165E8cA42C14C0FdE7",
    router: "0x8c1A3cF8f83074169FE5D7aD50B978e1cD6b37c7",
    startTime: 1694441499, //Date and time (GMT): Thursday, September 7, 2023 2:22:25 PM
    devAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    feeAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    masterChefAddress: "0x58f5F2AD3cfC3690B026170c7E3BE0582BE5148A",
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
    const router = await ethers.getContractAt("PancakeRouter", config.router);

    const token = await ethers.getContractAt(
        "WildToken",
        "0x3Bd80f5c62784D4a31e312E2801025E8c0b3Ad1f"
    );
    // await utils.deployAndVerify("WildToken", [router.address, config.devAddress]);

    // await token.mint(config.devAddress, ethers.utils.parseEther("250000"));

    // const masterChef = await utils.deployAndVerify("WildMasterChef", [
    //     token.address,
    //     config.devAddress, //dev address
    //     config.feeAddress, //fee address
    //     ethers.utils.parseUnits("1", 18),
    //     config.startTime,
    // ]);

    // await token.transferOwnership(masterChef.address);

    const masterChef = await ethers.getContractAt("WildMasterChef", config.masterChefAddress);

    // await masterChef.add(120, token.address, 0, false, false);
    // await masterChef.add(50, config.weth, 300, false, false);
    // await masterChef.add(30, config.alb, 300, false, false);

    // const wildWethPair = await factory.getPair(config.weth, token.address);
    const wildUsdcPair = await factory.getPair(config.usdc, token.address);
    const wildDaiPair = await factory.getPair(config.dai, token.address);
    const wildMimPair = await factory.getPair(config.mim, token.address);

    console.log({
        // wildWethPair: wildWethPair,
        wildUsdcPair: wildUsdcPair,
        wildDaiPair: wildDaiPair,
        wildMimPair: wildMimPair,
    });

    // await masterChef.add(200, wildWethPair, 200, false, false);
    await masterChef.add(200, wildUsdcPair, 200, false, false);
    await masterChef.add(200, wildDaiPair, 200, false, false);
    await masterChef.add(200, wildMimPair, 200, false, false);

    // const zapper = await utils.deployAndVerify("ZapV2", [masterChef.address]);

    // await zapper.setCoreValues(
    //     config.router,
    //     token.address,
    //     wildWethPair,
    //     token.address,
    //     wildWethPair,
    //     config.weth
    // );

    console.log({
        token: token.address,
        masterChef: masterChef.address,
        // zapper: zapper.address,
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
