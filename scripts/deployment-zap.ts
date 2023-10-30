import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    feeAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    deployerAddress: '0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893',
    wild: "0xA98A6be9dC0AdAe0B06925387cE02BbB53C8edeC",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    baseLp: "0x2A2747fF5e421DABDd64835892Efab2F6589B063",
    zapper: "0x81b542A3C09F3ac8bf6114D1eE324eB7a28d54FC"
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
