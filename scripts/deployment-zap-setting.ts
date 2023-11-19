import { ethers } from "hardhat";

const config = {
    factory: "0x29eA7545DEf87022BAdc76323F373EA1e707C523",
    router: "0x165C3410fC91EF562C50559f7d2289fEbed552d9",
    feeAddress: "0xD7544E32014F4D0ad77bf5084C8Cbd2321b7a930",
    deployerAddress: "0x41140Df415A2898937d147842C314c70B3aab82E",
    wild: "0xC846115E78a9747aA4aDD1f0da34A9001b87d83d",
    usdc: "0x15D38573d2feeb82e7ad5187aB8c1D52810B1f07",
    usdt: "0x0Cb6F5a34ad42ec934882A05265A7d5F59b51A2f",
    wpls: "0xA1077a294dDE1B09bB078844df40758a5D0f9a27",
    baseLp: "0xa3017359377db29e3a54f170a8e7cf899a409e25",
    dai: "0xefD766cCb38EaF1dfd701853BFCe31359239F305",
    zapper: "0xd88927A667e9883e101CEf509A8Da100F00c71fd"
};

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
