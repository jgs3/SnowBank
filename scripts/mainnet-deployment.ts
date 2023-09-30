import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E",
    router: "0x8cFe327CEc66d1C090Dd72bd0FF11d690C33a2Eb",
    startBlock: 4606038, //Date and time (GMT): Thursday, September 7, 2023 2:22:25 PM
    devAddress: "0xe2C1Fe4EB639D56FB955Ce63A2dADFdFB7dC5bB3",
    feeAddress: "0xe2C1Fe4EB639D56FB955Ce63A2dADFdFB7dC5bB3",
    deployerAddress: '0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893',
    masterChefAddress: "0x5D308B84aFa92117A1650b1BeeA6F4BAD2AD3e7b",
    wild: "0x3283A953b47Fe7b2c6Aa0306D6d7D1e2dFF383AB",
    usdc: "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",
    weth: "0x4200000000000000000000000000000000000006",
    dai: "0x50c5725949A6F0c72E6C4a641F24049A917DB0Cb",
    mim: "0x4A3A6Dd60A34bB2Aba60D73B4C88315E9CeB6A3D",
    alb: "0x1dd2d631c92b1aCdFCDd51A0F7145A50130050C4",
    sushi: "0x81aB7E0D570b01411fcC4afd3D50eC8C241cb74b",
    uni: "0x1dd2d631c92b1aCdFCDd51A0F7145A50130050C4",
    baseLp: "0x79474223AEdD0339780baCcE75aBDa0BE84dcBF9"
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const router = await ethers.getContractAt("PancakeRouter", config.router);

    // const token = await ethers.getContractAt("WILDX", config.wild);
    const token = await utils.deployAndVerify("WILDX", [config.usdc, config.router]);

    await token.mint(config.feeAddress, ethers.utils.parseEther("200000"));

    const masterChef = await utils.deployAndVerify("MasterChef", [
        token.address,
        config.devAddress, //dev address
        config.feeAddress, //fee address
        ethers.utils.parseUnits("1", 1),
        config.startBlock,
    ]);

    // await token.transferOwnership(masterChef.address);

    // const masterChef = await ethers.getContractAt("WildMasterChef", config.masterChefAddress);



    const wildWethPair = await factory.getPair(config.weth, token.address);
    const usdcWethPair = await factory.getPair(config.usdc, token.address);
    const wethUSDCPair = await factory.getPair(config.usdc, config.weth);
    // const wildUsdcPair = await factory.getPair(config.usdc, token.address);
    // const wildDaiPair = await factory.getPair(config.dai, token.address);
    // const wildMimPair = await factory.getPair(config.mim, token.address);

    await masterChef.add(100, token.address, 0, false);
    await masterChef.add(50, config.weth, 400, false);
    await masterChef.add(850, wildWethPair, 0, false);
    await masterChef.add(0, config.baseLp, 400, false);

    console.log({
        wildWethPair: wildWethPair,
        usdcWethPair: usdcWethPair,
        wethUSDCPair: wethUSDCPair,
        // wildDaiPair: wildDaiPair,
        // wildMimPair: wildMimPair,
    });

    // await masterChef.add(800, wildWethPair, 200, false, false);
    // await masterChef.add(200, wildUsdcPair, 200, false, false);
    // await masterChef.add(200, wildDaiPair, 200, false, false);
    // await masterChef.add(200, wildMimPair, 200, false, false);

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
        // masterChef: masterChef.address,
        // zapper: zapper.address,
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
