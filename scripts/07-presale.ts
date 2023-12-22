import { ethers } from "hardhat";
const utils = require("../scripts/utils");

import { config } from "./config";

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
<<<<<<< HEAD
    const presaleContract = await utils.deployAndVerify("GEMPresale", [config.gem]);
=======
    const presaleContract = await utils.deployAndVerify("SNOWPresale", [config.snow, config.nft]);
>>>>>>> 17ff097522f1332e2fdfe3320d2d32e04d4477f4

    console.log({
        presaleContract: presaleContract.address,
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
