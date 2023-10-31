import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    nft: "0xa07eae08eC9d7Ff5a6E1B626aD7F147D87482667",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const nftContract = await utils.deployAndVerify("TreeWiLDNFT", ["3WiLD NFT", "3WiLDNFT", "https://wildbase.farm/images/bsc-nfts/"]);
    // const nftContract = await ethers.getContractAt("WILDxNFT", config.nft);
   const addresses = [
    "0x7c16Bb273156b75F02123f3ee156e54813b036d6",
    "0x8F1D8C788E15c1E8de99DcE8E2d23a3a513fc62a",
    "0xF4E13D7c879FAc90875900084CBE4B0DD98d698E",
    "0xFb654eB9c626DAb3E2Ba0D00c2f89f51cF9Fcc46",
    "0xd3f9fdc072e169f09a49132963e45d8de055815d",
    "0x4EA2e907d9C61Fc569D9dd394320C18eC1F7e507",
    "0x1a82c11623d439ebCA170f448b9e59a3D116b793",
    "0xdadaf17382dea313d1c589e51fcaa7ffdf48f8c0",
    "0x50924bbC1d25CD401E0561346aacEade3d6f9925",
    "0x59651B14d02De11636208Bb8096E77F6b8Eb0E66",
    "0x1116bF593285d11207E5c3ec0166388C3f877850",
    "0xa7c542018a9ED6028A38DAB7EA0fBc89AA240E19",
    "0xc7275d78B3147C717E75ef9035990920d9FcBfF5",
    "0x3541f1E32bBE07D1f83e7d2866C6f3F23734889F",
    "0xa84BDF49E4BDD101884Ea2FEf6C33cD8d9e845b5",
    "0xe1E7AdC5F8CDC7c41d495989db1f5E047bBCd7ce",
    "0x733b2d8E1714860D83Cb335f8ca59baEa148dde0",
    "0xbb5f5ffeff0d0c2d972fa9ab3172da180845c337",
    "0xB148d6B90F46709CC9f48adDf4cc9561930d0286",
    "0x624fD4F9a45598349ace80bC9405840d951B4456",
    "0x37B12779DF924a8B33bEcDa3ef677312a6515826",
    "0xA80041D8bE9F128B75b42B47ba1e9bf688b6213C",
    "0x4B38466EA1E72cB6c2912B5e669C1570adB8ac7a",
    "0xec4Acd46A9Adec6223E47dd02520921B64a29938",
    "0x57fD1260B14914E8E9DD468b6e2130EcA353f749",
    "0x74CBC55f2292f8Ce097fCe80e3a8d0833655adb8",
    "0x9191E055038dAD57A4046Bdcb37292281622e4C9",
    "0xf640288a25f920ef4579e2c28b28f9552a70c689",
    "0x797668011572321052F51907FC903EDF7BdFBB81",
    "0x0dE0Fc798339022bbb42F5F653dAa6Ef05b341cd",
];

const amounts = [
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    3,
  ]

    console.log("adding whitelist...");
    const tx = await nftContract.setWhiteListsWithMaximumAmount(addresses, amounts);
    await tx.wait()
    console.log("done");

    console.log({
        nftContract: nftContract.address
    });
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
