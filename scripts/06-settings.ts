import { ethers } from "hardhat";
const utils = require("../scripts/utils");
const { config } = require("../scripts/config");

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    // const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const token = await ethers.getContractAt("GEMToken", config.gem);
    // const zapper = await ethers.getContractAt("ZapV3", config.zap);
    // const nft = await ethers.getContractAt("GEMNFT", config.nft);
    const masterchef = await ethers.getContractAt("MasterChef", config.masterchef);

    // console.log("setting zapper to whitelist...");
    // await token.setProxy(config.zap);
    // console.log("done");

    // console.log("setting lp contract to pair...");
    // await token.setPair(config.baseLp);
    // console.log("done");

    // console.log("transferring ownership to masterchef...");
    // await token.transferOwnership(config.masterchef);
    // console.log("done");

    // // whitelistUser
    // console.log("setting masterchef to whitelist in nft...");
    // await nft.whitelistUser(config.masterchef);
    // console.log("done");

    // console.log("updating emission...");
    // await masterchef.updateEmissionRate("50000000000000000");
    // console.log("done");

    console.log("updating emission...");
    await masterchef.updateEmissionRate("500000000000");
    console.log("done");

    // setWhiteListWithMaximumAmount
    // console.log("setWhiteListWithMaximumAmount in nft...", config.feeAddress);
    // await nft.setWhiteListWithMaximumAmount(config.feeAddress, 5);
    // console.log("done");

    // console.log("mint nft...");
    // await nft.mint();
    // await nft.mint();
    // await nft.mint();
    // await nft.mint();
    // await nft.mint();
    // console.log("done");
    // console.log("transferring ownership of masterchef...");
    // await masterchef.transferOwnership(config.owner);
    // console.log("done");

    // console.log("transferring ownership of NFT...");
    // await nft.transferOwnership(config.devAddress1);
    // console.log("done");

    // console.log("updating pool info...");
    // await masterchef.set(0, 950, 100, 1698733996, true);
    // await masterchef.set(2, 50, 300, 1698733996, true);
    // console.log("done");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
