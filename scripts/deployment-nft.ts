import { ethers } from "hardhat";
const utils = require("../scripts/utils");

// const config = {
//     nft: "0x16e209ee047B0d0fb1829Ef072EA6Ace8e6Ec463",
// };

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const nftContract = await utils.deployAndVerify("ThreeWiLDNFT", [
        "pWiLD NFT",
        "pWiLDNFT",
        "https://wildbase.farm/images/pulse-nfts/",
    ]);
    // const nftContract = await ethers.getContractAt("TreeWiLDNFT", config.nft);
    // const addresses = [
    //     // "0x7c16Bb273156b75F02123f3ee156e54813b036d6",
    //     // "0x8F1D8C788E15c1E8de99DcE8E2d23a3a513fc62a",
    //     // "0xF4E13D7c879FAc90875900084CBE4B0DD98d698E",
    //     // "0xFb654eB9c626DAb3E2Ba0D00c2f89f51cF9Fcc46",
    //     // "0xd3f9fdc072e169f09a49132963e45d8de055815d",
    //     // "0x4EA2e907d9C61Fc569D9dd394320C18eC1F7e507",
    //     // "0x1a82c11623d439ebCA170f448b9e59a3D116b793",
    //     // "0xdadaf17382dea313d1c589e51fcaa7ffdf48f8c0",
    //     // "0x50924bbC1d25CD401E0561346aacEade3d6f9925",
    //     // "0x59651B14d02De11636208Bb8096E77F6b8Eb0E66",
    //     // "0x1116bF593285d11207E5c3ec0166388C3f877850",
    //     // "0xa7c542018a9ED6028A38DAB7EA0fBc89AA240E19",
    //     // "0xc7275d78B3147C717E75ef9035990920d9FcBfF5",
    //     // "0x3541f1E32bBE07D1f83e7d2866C6f3F23734889F",
    //     // "0xa84BDF49E4BDD101884Ea2FEf6C33cD8d9e845b5",
    //     // "0xe1E7AdC5F8CDC7c41d495989db1f5E047bBCd7ce",
    //     // "0x733b2d8E1714860D83Cb335f8ca59baEa148dde0",
    //     // "0xbb5f5ffeff0d0c2d972fa9ab3172da180845c337",
    //     // "0xB148d6B90F46709CC9f48adDf4cc9561930d0286",
    //     // "0x624fD4F9a45598349ace80bC9405840d951B4456",
    //     // "0x37B12779DF924a8B33bEcDa3ef677312a6515826",
    //     // "0xA80041D8bE9F128B75b42B47ba1e9bf688b6213C",
    //     // "0x4B38466EA1E72cB6c2912B5e669C1570adB8ac7a",
    //     // "0xec4Acd46A9Adec6223E47dd02520921B64a29938",
    //     // "0x57fD1260B14914E8E9DD468b6e2130EcA353f749",
    //     // "0x74CBC55f2292f8Ce097fCe80e3a8d0833655adb8",
    //     // "0x9191E055038dAD57A4046Bdcb37292281622e4C9",
    //     // "0xf640288a25f920ef4579e2c28b28f9552a70c689",
    //     // "0x797668011572321052F51907FC903EDF7BdFBB81",
    //     // "0x0dE0Fc798339022bbb42F5F653dAa6Ef05b341cd",
    //     "0xb2A056c6961b8801Eb7A0F27ee6487440c18086f"
    // ];

    // const amounts = [
    //     1,// 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3,
    // ];

    const addresses = [
        "0x8e5D12250299007801049597875605c304Edf058"
        // "0x4dc8EfbFDC9213e13e22DDB22fb563ee5f4cF4C2"
        // "0x4B12435D43010972915cbf7dAafe0d1785160313",
        // "0x4B12435D43010972915cbf7dAafe0d1785160313"
        // "0xa54CF8845AB2F560bF9AeB6e2d1648a69D4c6529"
// "0x812f22A8539Dabfb7260132190397A9dA458e41A",
// "0x13d6eb1fefa628aAaF36B6eCAC94A4e9c6a75441",
// "0x68Ae261E6eE6c25206b4F78DF6fA645D79d38a66",
// "0x3849126e937b9Aad4200822955e1b58F9817fE7E",
// "0xB95eeAd438Cc2d01a0c4C6f784b658Ab770348eE",
// "0xd02699638E75c7a1FB7c6521b7C61172458a828E",
// "0x37B12779DF924a8B33bEcDa3ef677312a6515826",
// "0x98Be2f963343fa37b324070984Ffd72b0460eDbE",
// "0xA5CA0dc6e9b63F41D79026Dc0048F38e9F95b547",
// "0x7B1d3bB271Aa9144A0f058553383fb0b696f441B",
// "0x6f5563181bac2a019223b6908877ff4a9a71ebac",
// "0xD7544E32014F4D0ad77bf5084C8Cbd2321b7a930",
// "0x92760Ef128C9c5A35fef861d818B522F7a0CbEEF",
// "0x146695f336d600e9fbc78185aa0e64104fc191f2",
// "0x4d9b06250b0202ae5eb20ba31f35635f1f413635",
// "0xe4AB985E3CCb5528343086B478Fe4D67853D81C4",
]

const amounts = [
    1
    // 1,
    // 2,
    // 2,
    // 1,
    // 1,
    // 4,
    // 1,
    // 5,
    // 1,
    // 2,
    // 3,
    // 3,
    // 3,
    // 1,
    // 3,
    // 3,
]

    console.log("adding whitelist...");
    const tx = await nftContract.setWhiteListsWithMaximumAmount(addresses, amounts);
    await tx.wait()
    console.log("done");

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
