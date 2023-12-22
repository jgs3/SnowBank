import { ethers } from "hardhat";

import { config } from "./config";

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const zapper = await ethers.getContractAt("ZapV3", config.zap);

    await zapper.setCoreValues(
        config.router,
        config.factory,
<<<<<<< HEAD
        config.gem,
=======
        config.snow,
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4
        config.baseLp,
        config.weth
    );

<<<<<<< HEAD
    // weth - gem
    console.log("set swap path for weth-gem");
    await zapper.setSwapPath(config.gem, config.weth, [config.gem, config.weth]);
    await zapper.setSwapPath(config.weth, config.gem, [config.weth, config.gem]);
=======
    // weth - snow
    console.log("set swap path for weth-snow");
    await zapper.setSwapPath(config.snow, config.weth, [config.snow, config.weth]);
    await zapper.setSwapPath(config.weth, config.snow, [config.weth, config.snow]);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4


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
