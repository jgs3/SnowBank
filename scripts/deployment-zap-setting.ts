import { ethers } from "hardhat";

const { config } = require("../scripts/config");


async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const zapper = await ethers.getContractAt("ZapV3", config.zap);

    await zapper.setCoreValues(
        config.router,
        config.factory,
        config.wild,
        config.baseLp,
        config.weth
    );

    console.log("set token type for mim");
    await zapper.setTokenType(config.mim, 1);
    console.log("set token type for dai");
    await zapper.setTokenType(config.dai, 1);
    console.log("set token type for usdc");
    await zapper.setTokenType(config.usdc, 1);

    // weth - wild
    console.log("set swap path for mim-weth");
    await zapper.setSwapPath(config.wild, config.weth, [config.wild, config.weth]);
    await zapper.setSwapPath(config.weth, config.wild, [config.weth, config.wild]);

    // weth - usdc
    console.log("set swap path for mim-weth");
    await zapper.setSwapPath(config.usdc, config.weth, [config.usdc, config.weth]);
    await zapper.setSwapPath(config.weth, config.usdc, [config.weth, config.usdc]);

    // weth - dai
    console.log("set swap path for mim-weth");
    await zapper.setSwapPath(config.dai, config.weth, [config.dai, config.weth]);
    await zapper.setSwapPath(config.weth, config.dai, [config.weth, config.dai]);

    // weth - mim
    console.log("set swap path for mim-weth");
    await zapper.setSwapPath(config.mim, config.weth, [config.mim, config.weth]);
    await zapper.setSwapPath(config.weth, config.mim, [config.weth, config.mim]);

    // wild - mim
    console.log("set swap path for mim-wild");
    await zapper.setSwapPath(config.wild, config.mim, [config.wild, config.weth, config.mim]);
    await zapper.setSwapPath(config.mim, config.wild, [config.mim, config.weth, config.wild]);

    // wild - usdc
    console.log("set swap path for mim-wild");
    await zapper.setSwapPath(config.wild, config.usdc, [config.wild, config.weth, config.usdc]);
    await zapper.setSwapPath(config.usdc, config.wild, [config.usdc, config.weth, config.wild]);

    // wild - dai
    console.log("set swap path for mim-wild");
    await zapper.setSwapPath(config.wild, config.dai, [config.wild, config.weth, config.dai]);
    await zapper.setSwapPath(config.dai, config.wild, [config.dai, config.weth, config.wild]);

    // usdc - mim
    console.log("set swap path for mim-usdc");
    await zapper.setSwapPath(config.usdc, config.mim, [config.usdc, config.weth, config.mim]);
    await zapper.setSwapPath(config.mim, config.usdc, [config.mim, config.weth, config.usdc]);

    // usdc - dai
    console.log("set swap path for mim-usdc");
    await zapper.setSwapPath(config.usdc, config.dai, [config.usdc, config.weth, config.dai]);
    await zapper.setSwapPath(config.dai, config.usdc, [config.dai, config.weth, config.usdc]);

    // mim - dai
    console.log("set swap path for mim-dai");
    await zapper.setSwapPath(config.dai, config.mim, [config.dai, config.weth, config.mim]);
    await zapper.setSwapPath(config.mim, config.dai, [config.mim, config.weth, config.dai]);

    console.log({
        zapper: zapper.address,
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
