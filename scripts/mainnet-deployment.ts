import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    startBlock: 4660000, //Date and time (GMT): Thursday, September 7, 2023 2:22:25 PM
    devAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    feeAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    deployerAddress: '0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893',
    wild: "0xbCDa0bD6Cd83558DFb0EeC9153eD9C9cfa87782E",
    usdc: "0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d",
    wbnb: "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c",
    baseLp: "0xB775272E537cc670C65DC852908aD47015244EaF"
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const router = await ethers.getContractAt("PancakeRouter", config.router);

    // const token = await utils.deployAndVerify("WildToken", [config.usdc, config.router]);

    // await token.mint(config.feeAddress, ethers.utils.parseEther("500000"));

    // const masterChef = await utils.deployAndVerify("MasterChef", [
    //     token.address,
    //     config.devAddress, //dev address
    //     config.feeAddress, //fee address
    //     0,
    //     config.startBlock,
    // ]);

    // await token.transferOwnership(masterChef.address);

    // const masterChef = await ethers.getContractAt("WildMasterChef", config.masterChefAddress);



    // const wildWethPair = await factory.getPair(config.wbnb, token.address);
    // const usdcWethPair = await factory.getPair(config.usdc, token.address);
    const wethUSDCPair = await factory.getPair(config.usdc, config.wbnb);
    const USDCwethPair = await factory.getPair(config.wbnb, config.usdc);
    // const wildUsdcPair = await factory.getPair(config.usdc, token.address);
    // const wildDaiPair = await factory.getPair(config.dai, token.address);
    // const wildMimPair = await factory.getPair(config.mim, token.address);

    // await masterChef.add(100, token.address, 0, false);
    // await masterChef.add(50, config.wbnb, 400, false);
    // await masterChef.add(850, wildWethPair, 0, false);
    // await masterChef.add(0, config.baseLp, 400, false);

    console.log({
        // wildWethPair: wildWethPair,
        // usdcWethPair: usdcWethPair,
        wethUSDCPair: wethUSDCPair,
        USDCwethPair: USDCwethPair,
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
    //     config.wbnb
    // );

    console.log({
        // token: token.address,
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
