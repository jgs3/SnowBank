import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    factory: "0x29eA7545DEf87022BAdc76323F373EA1e707C523",
    router: "0x165C3410fC91EF562C50559f7d2289fEbed552d9",
    feeAddress: "0x41140Df415A2898937d147842C314c70B3aab82E",
    deployerAddress: "0x41140Df415A2898937d147842C314c70B3aab82E",
    wild: "0xa32Ba2Bb68753c5bAbd0c110Ba3FF7E688018917",
    usdc: "0x15D38573d2feeb82e7ad5187aB8c1D52810B1f07",
    weth: "0x4DB5a66E937A9F4473fA95b1cAF1d1E1D62E29EA",
    wpls: "0xA1077a294dDE1B09bB078844df40758a5D0f9a27",
    zapper: "0x556BEf0Ee5CB5D3d46398a6042D81b622118059E",
    masterchef: "0xA24299910CE35CB4CF0133f7b612E503C2cA9e31",
    nft:"0xE7a51374E42cb2D0AE1c3cf3399710a9DCd5A0A5",
    baseLp:"0xA24299910CE35CB4CF0133f7b612E503C2cA9e31",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const factory = await ethers.getContractAt("PancakeFactory", config.factory);
    const token = await ethers.getContractAt("PWildToken", config.wild);
    const zapper = await ethers.getContractAt("ZapV3", config.zapper);
    const nft = await ethers.getContractAt("PWiLDNFT", config.nft);
    const masterchef = await ethers.getContractAt("MasterChef", config.masterchef);

    // await token.mint(config.feeAddress, ethers.utils.parseEther("5000"));

    console.log("setting zapper to whitelist...");
    await token.setProxy(config.zapper);
    console.log("done");

    console.log("setting lp contract to pair...");
    await token.setPair(config.baseLp);
    console.log("done");

    console.log("transferring ownership to masterchef...");
    await token.transferOwnership(config.masterchef);
    console.log("done");

    // whitelistUser
    console.log("setting masterchef to whitelist in nft...");
    await nft.whitelistUser(config.masterchef);
    console.log("done");
    console.log("updating emission...");
    await masterchef.updateEmissionRate("11000000000000000");
    console.log("done");

    // setWhiteListWithMaximumAmount
    console.log("setWhiteListWithMaximumAmount in nft...");
    await nft.setWhiteListWithMaximumAmount(config.feeAddress, 3);
    console.log("done");

    console.log("mint nft...");
    await nft.mint();
    await nft.mint();
    await nft.mint();
    console.log("done");
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
