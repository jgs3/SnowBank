import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0x29eA7545DEf87022BAdc76323F373EA1e707C523",
    router: "0x165C3410fC91EF562C50559f7d2289fEbed552d9",
    feeAddress: "0x41140Df415A2898937d147842C314c70B3aab82E",
    deployerAddress: "0x41140Df415A2898937d147842C314c70B3aab82E",
    wild: "0x2F32211682af0B8d2394C773980ce65b7031A80e",
    usdc: "0x15D38573d2feeb82e7ad5187aB8c1D52810B1f07",
    weth: "0x4DB5a66E937A9F4473fA95b1cAF1d1E1D62E29EA",
    wpls: "0xA1077a294dDE1B09bB078844df40758a5D0f9a27",
    zapper: "0x4367332aCE7966d9701A6aCd0f0554af0D675De9",
    masterchef: "0xcD5758A05824A2dE76586649779b21509F948746",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    // const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const token = await ethers.getContractAt("PWildToken", config.wild);
    // const zapper = await ethers.getContractAt("PWildToken", config.zapper);
    // const masterchef = await ethers.getContractAt("MasterChef", config.masterchef);

    await token.mint(config.feeAddress, ethers.utils.parseEther("5000"));

    // console.log("setting zapper to whitelist...");
    // await token.setProxy(config.zapper);
    // console.log("done");
    console.log("transferring ownership to masterchef...");
    await token.transferOwnership(config.masterchef);
    console.log("done");

    // console.log("updating emission...");
    // await masterchef.updateEmissionRate("11000000000000000");
    // console.log("done");

    // console.log("transferring ownership of masterchef...");
    // await masterchef.transferOwnership(config.feeAddress);
    // console.log("done");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
