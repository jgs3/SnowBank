import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E",
    router: "0x8cFe327CEc66d1C090Dd72bd0FF11d690C33a2Eb",
    feeAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    deployerAddress: "0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893",
    wild: "0xEE24730A00943A16A2C4c84055eFbc14a6E51220",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    baseLp: "0x5a7b2a9cD64177AED1596e7B39d1426a93725611",
    zapper: "0xE102A51014b3FFb69E7Be5d8d0a13510A0b93b56"
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    // const zapper = await utils.deployAndVerify("ZapV3");
    const zapper = await ethers.getContractAt("ZapV3", config.zapper);

    await zapper.setCoreValues(
        config.router,
        config.factory,
        config.wild,
        config.baseLp,
        config.wbnb
    );
    await zapper.setTokenType(config.usdc, 1);
    await zapper.setSwapPath(config.wild, config.wbnb, [config.wild, config.wbnb]);
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
