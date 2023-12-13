import { ethers } from "hardhat";
import { config } from "./config";

const utils = require("../scripts/utils");

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const nftContract = await utils.deployAndVerify("SNOWNFT", [
        "SNOW NFT",
        "SNOWNFT",
        "https://snowbase.pro/",
        config.deployerAddress
    ]);

    console.log({
        nftContract: nftContract.address,
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
