import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    feeAddress: "0xD7544E32014F4D0ad77bf5084C8Cbd2321b7a930",
    deployerAddress: "0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893",
    wild: "0xE9f49BE8C684A823102b33DA0cEa82c6e229F05C",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    busd: "0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56",
    usdt: "0x55d398326f99059fF775485246999027B3197955",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    baseLp: "0x244a0802b8E0cA0b77768F423124cba16f256013",
    zapper: "0x8C0Df30e63135eC82bBE0ABb8B28fEE078bAbc50",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    // const zapper = await utils.deployAndVerify("ZapV3");
    const zapper = await ethers.getContractAt("ZapV3", config.zapper);

    // await zapper.setCoreValues(
    //     config.router,
    //     config.factory,
    //     config.wild,
    //     config.baseLp,
    //     config.wbnb
    // );
    // await zapper.setTokenType(config.usdc, 1);
    await zapper.setTokenType(config.usdt, 1);
    
    // usdt - wbnb
    console.log('set swap path for usdt-wbnb');
    await zapper.setSwapPath(config.usdt, config.wbnb, [config.usdt, config.wbnb]);
    await zapper.setSwapPath(config.wbnb, config.usdt, [config.wbnb, config.usdt]);
    
    // wild - usdt
    console.log('set swap path for usdt-wild');
    await zapper.setSwapPath(config.wild, config.usdt, [config.wild, config.wbnb, config.usdt]);
    await zapper.setSwapPath(config.usdt, config.wild, [config.usdt, config.wbnb, config.wild]);

    // usdc - usdt
    console.log('set swap path for usdt-usdc');
    await zapper.setSwapPath(config.usdc, config.usdt, [config.usdc, config.wbnb, config.usdt]);
    await zapper.setSwapPath(config.usdt, config.usdc, [config.usdt, config.wbnb, config.usdc]);

    // usdt - busd
    console.log('set swap path for usdt-busd');
    await zapper.setSwapPath(config.busd, config.usdt, [config.busd, config.wbnb, config.usdt]);
    await zapper.setSwapPath(config.usdt, config.busd, [config.usdt, config.wbnb, config.busd]);

    console.log({
        // token: config.wild,
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
