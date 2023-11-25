import { ethers } from "hardhat";
const { config } = require("../scripts/config");

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const zapper = await ethers.getContractAt("ZapV3", config.zapper);

    await zapper.setCoreValues(
        config.router,
        config.factory,
        config.wild,
        config.baseLp,
        config.wpls
    );

    console.log("set token type for usdt");
    await zapper.setTokenType(config.usdt, 1);
    console.log("set token type for dai");
    await zapper.setTokenType(config.dai, 1);
    console.log("set token type for usdc");
    await zapper.setTokenType(config.usdc, 1);

    // wpls - wild
    console.log("set swap path for usdt-wpls");
    await zapper.setSwapPath(config.wild, config.wpls, [config.wild, config.wpls]);
    await zapper.setSwapPath(config.wpls, config.wild, [config.wpls, config.wild]);

    // wpls - usdc
    console.log("set swap path for usdt-wpls");
    await zapper.setSwapPath(config.usdc, config.wpls, [config.usdc, config.wpls]);
    await zapper.setSwapPath(config.wpls, config.usdc, [config.wpls, config.usdc]);

    // wpls - dai
    console.log("set swap path for usdt-wpls");
    await zapper.setSwapPath(config.dai, config.wpls, [config.dai, config.wpls]);
    await zapper.setSwapPath(config.wpls, config.dai, [config.wpls, config.dai]);

    // wpls - usdt
    console.log("set swap path for usdt-wpls");
    await zapper.setSwapPath(config.usdt, config.wpls, [config.usdt, config.wpls]);
    await zapper.setSwapPath(config.wpls, config.usdt, [config.wpls, config.usdt]);

    // wild - usdt
    console.log("set swap path for usdt-wild");
    await zapper.setSwapPath(config.wild, config.usdt, [config.wild, config.wpls, config.usdt]);
    await zapper.setSwapPath(config.usdt, config.wild, [config.usdt, config.wpls, config.wild]);

    // wild - usdc
    console.log("set swap path for usdt-wild");
    await zapper.setSwapPath(config.wild, config.usdc, [config.wild, config.wpls, config.usdc]);
    await zapper.setSwapPath(config.usdc, config.wild, [config.usdc, config.wpls, config.wild]);

    // wild - dai
    console.log("set swap path for usdt-wild");
    await zapper.setSwapPath(config.wild, config.dai, [config.wild, config.wpls, config.dai]);
    await zapper.setSwapPath(config.dai, config.wild, [config.dai, config.wpls, config.wild]);

    // usdc - usdt
    console.log("set swap path for usdt-usdc");
    await zapper.setSwapPath(config.usdc, config.usdt, [config.usdc, config.wpls, config.usdt]);
    await zapper.setSwapPath(config.usdt, config.usdc, [config.usdt, config.wpls, config.usdc]);

    // usdc - dai
    console.log("set swap path for usdt-usdc");
    await zapper.setSwapPath(config.usdc, config.dai, [config.usdc, config.wpls, config.dai]);
    await zapper.setSwapPath(config.dai, config.usdc, [config.dai, config.wpls, config.usdc]);

    // usdt - dai
    console.log("set swap path for usdt-dai");
    await zapper.setSwapPath(config.dai, config.usdt, [config.dai, config.wpls, config.usdt]);
    await zapper.setSwapPath(config.usdt, config.dai, [config.usdt, config.wpls, config.dai]);

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
