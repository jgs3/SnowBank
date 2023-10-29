import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E",
    router: "0x8cFe327CEc66d1C090Dd72bd0FF11d690C33a2Eb",
    feeAddress: "0xAE02196968A374A2d1281eD082F7A66b510FA8aD",
    deployerAddress: "0x600bE5FcB9338BC3938e4790EFBeAaa4F77D6893",
    wild: "0xd413E20a693821A1A6e49384B7Db6Bde22d2c492",
    usdc: "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d",
    weth: "0x4DB5a66E937A9F4473fA95b1cAF1d1E1D62E29EA",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    baseLp: "0x91966eDa724a75730AcdA90601e2dB549095dC61",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const zapper = await utils.deployAndVerify("ZapV3");

    await zapper.setCoreValues(
        config.router,
        config.factory,
        config.wild,
        config.baseLp,
        config.wbnb
    );
    await zapper.setSwapPath(config.weth, config.wild, [config.weth, config.wild]);
    await zapper.setSwapPath(config.wild, config.weth, [config.wild, config.weth]);
    await zapper.setSwapPath(config.wild, config.wbnb, [config.wild, config.wbnb]);
    await zapper.setSwapPath(config.wbnb, config.wild, [config.wbnb, config.wild]);

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
