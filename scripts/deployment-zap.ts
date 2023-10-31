import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    feeAddress: "0xD7544E32014F4D0ad77bf5084C8Cbd2321b7a930",
    deployerAddress: '0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893',
    wild: "0xf72A55ADE28437Ef331a34FDa4842835EB8863E9",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    baseLp: "0x4DE35Ce49814b61fF46c7F3DF7dFabd5ea301C8E",
    zapper: "0x4992d255ff117F8e4c0159bB5b9A7AfAbA6D377c"
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const zapper = await utils.deployAndVerify("ZapV3");
    // const zapper = await ethers.getContractAt("ZapV3", config.zapper);

    await zapper.setCoreValues(
        config.router,
        config.factory,
        config.wild,
        config.baseLp,
        config.wbnb
    );
    await zapper.setTokenType(config.usdc, 1);
    await zapper.setSwapPath(config.wild, config.wbnb, [config.wild, config.wbnb]);
    await zapper.setSwapPath(config.wbnb, config.wild, [config.wbnb, config.wild]);
    await zapper.setSwapPath(config.wild, config.usdc, [config.wild, config.wbnb, config.usdc]);
    await zapper.setSwapPath(config.usdc, config.wild, [config.usdc, config.wbnb, config.wild]);
    await zapper.setSwapPath(config.wbnb, config.usdc, [config.wbnb, config.usdc]);
    await zapper.setSwapPath(config.usdc, config.wbnb, [config.usdc, config.wbnb]);

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
