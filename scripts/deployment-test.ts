import { ethers } from "hardhat";
const utils = require("../scripts/utils");

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    await utils.deployAndVerify("Test", []);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
