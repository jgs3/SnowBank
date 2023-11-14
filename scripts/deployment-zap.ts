import { ethers } from "hardhat";

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    feeAddress: "0xD7544E32014F4D0ad77bf5084C8Cbd2321b7a930",
    deployerAddress: "0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893",
    wild: "0xC5BDB5b8f5BDc6eD6251B250C69a20e329d66282",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    busd: "0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56",
    usdt: "0x55d398326f99059fF775485246999027B3197955",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    baseLp: "0xe8f4f415305f6dd40DC007c1132C9681E8625A31",
    zapper: "0x449d14e5D2C439a235E28A65CA1744a96355CF93",
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
        config.wbnb
    );

    console.log("set token type for usdt");
    await zapper.setTokenType(config.usdt, 1);
    console.log("set token type for busd");
    await zapper.setTokenType(config.busd, 1);
    console.log("set token type for usdc");
    await zapper.setTokenType(config.usdc, 1);

    // wbnb - wild
    console.log("set swap path for usdt-wbnb");
    await zapper.setSwapPath(config.wild, config.wbnb, [config.wild, config.wbnb]);
    await zapper.setSwapPath(config.wbnb, config.wild, [config.wbnb, config.wild]);

    // wbnb - usdc
    console.log("set swap path for usdt-wbnb");
    await zapper.setSwapPath(config.usdc, config.wbnb, [config.usdc, config.wbnb]);
    await zapper.setSwapPath(config.wbnb, config.usdc, [config.wbnb, config.usdc]);

    // wbnb - busd
    console.log("set swap path for usdt-wbnb");
    await zapper.setSwapPath(config.busd, config.wbnb, [config.busd, config.wbnb]);
    await zapper.setSwapPath(config.wbnb, config.busd, [config.wbnb, config.busd]);

    // wbnb - usdt
    console.log("set swap path for usdt-wbnb");
    await zapper.setSwapPath(config.usdt, config.wbnb, [config.usdt, config.wbnb]);
    await zapper.setSwapPath(config.wbnb, config.usdt, [config.wbnb, config.usdt]);

    // wild - usdt
    console.log("set swap path for usdt-wild");
    await zapper.setSwapPath(config.wild, config.usdt, [config.wild, config.wbnb, config.usdt]);
    await zapper.setSwapPath(config.usdt, config.wild, [config.usdt, config.wbnb, config.wild]);

    // wild - usdc
    console.log("set swap path for usdt-wild");
    await zapper.setSwapPath(config.wild, config.usdc, [config.wild, config.wbnb, config.usdc]);
    await zapper.setSwapPath(config.usdc, config.wild, [config.usdc, config.wbnb, config.wild]);

    // wild - busd
    console.log("set swap path for usdt-wild");
    await zapper.setSwapPath(config.wild, config.busd, [config.wild, config.wbnb, config.busd]);
    await zapper.setSwapPath(config.busd, config.wild, [config.busd, config.wbnb, config.wild]);

    // usdc - usdt
    console.log("set swap path for usdt-usdc");
    await zapper.setSwapPath(config.usdc, config.usdt, [config.usdc, config.wbnb, config.usdt]);
    await zapper.setSwapPath(config.usdt, config.usdc, [config.usdt, config.wbnb, config.usdc]);

    // usdc - busd
    console.log("set swap path for usdt-usdc");
    await zapper.setSwapPath(config.usdc, config.busd, [config.usdc, config.wbnb, config.busd]);
    await zapper.setSwapPath(config.busd, config.usdc, [config.busd, config.wbnb, config.usdc]);

    // usdt - busd
    console.log("set swap path for usdt-busd");
    await zapper.setSwapPath(config.busd, config.usdt, [config.busd, config.wbnb, config.usdt]);
    await zapper.setSwapPath(config.usdt, config.busd, [config.usdt, config.wbnb, config.busd]);

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
