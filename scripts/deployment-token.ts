import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0x29eA7545DEf87022BAdc76323F373EA1e707C523",
    router: "0x165C3410fC91EF562C50559f7d2289fEbed552d9",
    deployerAddress: '0xeE8fAeb94721106fDd385b852d806D0699b17D5e',
    usdc: "0x15D38573d2feeb82e7ad5187aB8c1D52810B1f07",
    wpls: "0xA1077a294dDE1B09bB078844df40758a5D0f9a27",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    // const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const token = await utils.deployAndVerify("PWildToken", []);

    // await token.mint(config.deployerAddress, ethers.utils.parseEther("5000"));

    // const wildWplsPair = await factory.getPair(config.wpls, token.address);
    // const usdcWethPair = await factory.getPair(config.usdc, config.wpls);

    console.log({
        token: token.address,
        // wildWplsPair: wildWplsPair,
        // usdcWethPair: usdcWethPair,
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
