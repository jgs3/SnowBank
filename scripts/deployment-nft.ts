import { ethers } from "hardhat";
const utils = require("../scripts/utils");

const config = {
    nft: "0xB258c44E1544e7d91AbC9A617252Ee2c94D8d542",
};

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    const nftContract = await utils.deployAndVerify("PWiLDNFT", [
        "pWiLD NFT",
        "pWiLDNFT",
        "https://wildbase.farm/images/pulse-nfts/",
    ]);
    // const nftContract = await ethers.getContractAt("PWiLDNFT", config.nft);


    const addresses = [
        // "0x812f22a8539dabfb7260132190397a9da458e41a",
        // "0xfb654eb9c626dab3e2ba0d00c2f89f51cf9fcc46",
        // "0xdc287907be45cadadedfd534295f82fbb978d1b3",
        // "0x08900cc758c3affab039d42fa388cd4c67123bce",
        // "0x34fe35514addfeed30fbdcf6758a5f606a05b49d",
        // "0xa80041d8be9f128b75b42b47ba1e9bf688b6213c",
        // "0x37b12779df924a8b33becda3ef677312a6515826",
        // "0xbb5f5ffeff0d0c2d972fa9ab3172da180845c337",
        // "0x7c16bb273156b75f02123f3ee156e54813b036d6",
        // "0xc7275d78b3147c717e75ef9035990920d9fcbff5",
        // "0x3541f1e32bbe07d1f83e7d2866c6f3f23734889f",
        // "0xd17a28a019c16ae2c27e73e7b88bddcc21e323b5",
        // "0x146695f336d600e9fbc78185aa0e64104fc191f2",
        // "0xd84b7a6d913bc4c4e103a3b0c06c3d837f38e990",
        // "0x4ea2e907d9c61fc569d9dd394320c18ec1f7e507",
        // "0xdadaf17382dea313d1c589e51fcaa7ffdf48f8c0",
        // "0x9191e055038dad57a4046bdcb37292281622e4c9",
        // "0x1e6edffb9b11251d8165641d282eee2f9a30b173",
        // "0x7b1d3bb271aa9144a0f058553383fb0b696f441b",
        // "0xa5ca0dc6e9b63f41d79026dc0048f38e9f95b547",
        // "0xaf3d2256ff5ae73ffccfd33b2781d8ff298cfb55",
        // "0xf4e13d7c879fac90875900084cbe4b0dd98d698e",
        // "0x92760ef128c9c5a35fef861d818b522f7a0cbeef",
        // "0x82fc986c484242414aeaba29f687c486c90331ef",
        // "0xa59f9f11fb165a1044a248474ce048dcf8602a63",
        // "0x600be5fcb9338bc3938e4790efbeaaa4f77d6893",
        // "0xb226ecc400c74015b4abb4ad13c08c3f2b32bc99",
        // "0x6f5563181bac2a019223b6908877ff4a9a71ebac",
        // "0xb8ee5ed792f1c29cb13ceeb4835bc3aa8855b3d6",
        // "0xb2a056c6961b8801eb7a0f27ee6487440c18086f",
        // "0xd02699638e75c7a1fb7c6521b7c61172458a828e",
        // "0xa8a0e45f3ebcadfaf20f316247c3211df8813d25",
        // "0x720651e4834b9a98b5f32fc851538f9b3a7a60cc",
        // "0x1a026cc905b4535f67a4bee2f19c32320991c2cc",
        // "0xfaf40a7620744bbbc953f9a294e42eeaefded851",
        // "0x781ee4325e03d3ca96532de0eee90fc842f63006",
        // "0x0af42f8620d464975b2fe92b1a20ae41390e8504",
        // "0x57013830fe1d1e6a960692c5841ae2b6aec11ded",
        // "0x9180cee3a5236668c6472128bdb9961a73b066da",
        // "0x382371705d48905637dac2abf5fee537300f5d3f",
        // "0x9354e7ae7b4458c201a577d14adec37188e9de7b",
        // "0x7da23bc4a403cad82a8ffa90ccd4e15c94850443",
        // "0xa724b79fceb5bdec15ae0de6a43512639e825117",
        // "0x6c8093cac45f9b08780b72b36d7c93961787dca7",
        // "0xeac2ff38f76f812ea7b3970ccf4f22938703bb08",
        // "0xc7a1c3090539ccbf9c34b3d15cbe6cfa0a9ad547",
        // "0xf01e83eaf2c5104dbf64f3fa53291a901464d2ef",
        // "0xca94e791eee754dd0df39c66de79e5c3e50b2d34",
        // "0xa68a860c69b1d4c1a6bba5c03a2d60fb37b8ad15",
        // "0xd0343c337fac8c81c733ffd9848ef5fe55b24795",
        // "0x8f1d8c788e15c1e8de99dce8e2d23a3a513fc62a",
        // "0x1116bf593285d11207e5c3ec0166388c3f877850",
        // "0x2aac0bab6fe67b147f50d8979acc922eadb76661",
        // "0x8e5d12250299007801049597875605c304edf058",
        // "0xceac8759e5476d4dc66d194c27b5456fbf4f3d86",
        // "0xec4acd46a9adec6223e47dd02520921b64a29938",
        // "0xe4ab985e3ccb5528343086b478fe4d67853d81c4",
        // "0x4d9b06250b0202ae5eb20ba31f35635f1f413635",
        // "0xd3f9fdc072e169f09a49132963e45d8de055815d",
        // "0x68ae261e6ee6c25206b4f78df6fa645d79d38a66",
        // "0xb148d6b90f46709cc9f48addf4cc9561930d0286",
        // "0x59651b14d02de11636208bb8096e77f6b8eb0e66",
        // "0x8cf28a5ee1cfb13f8ae6c9581246d655d98a28c1",
        // "0xc844b9c517c521f745384f2404449fd92b2de152",
        // "0x3c48771f152006576b6a9f55298fa93c53dd8ca2",
        // "0xefc9c2a1f244a5922ec118bee0c950bddb3d8870",
        // "0x9d2699358b4111eb4f8a2901d2f68c3c0cb2aeae",
        // "0x57fd1260b14914e8e9dd468b6e2130eca353f749",
        // "0x4b12435d43010972915cbf7daafe0d1785160313",
        // "0xa84bdf49e4bdd101884ea2fef6c33cd8d9e845b5",
        // "0xafc44e82c1a77859503913835969560cb772051a",
        // "0xa5ab2f21a7db787400e282e77ce4c1c9bdbd7451",
        // "0xdbb5cedacc86722ac44eab65fbd5fa4dc46fd8e1",
        // "0x13d6eb1fefa628aaaf36b6ecac94a4e9c6a75441",
        // "0x797668011572321052f51907fc903edf7bdfbb81",
        // "0x23a39dd71a0687a2cd33c41fe5e00a62d318c093",
        // "0xaba58f168ee39fdfb5e47ad6fa36fcc08914d396",
        // "0x4dc8efbfdc9213e13e22ddb22fb563ee5f4cf4c2",
        // "0xd3d604adf868dea9f3bbc77ba25432e932c4936c",
        // "0x3849126e937b9aad4200822955e1b58f9817fe7e",
        // "0x796a282a6e601af32a5c1e6cc63dfbe5f46d55bd",
        // "0x038355d7639b2aa6795b3213e05457ab838e11ea",
        // "0x60eb10f386eba81edd5e5e040b0eb23b7b026873",
        // "0xda22f3e1c4742dd3673e9db38a4131e88bbd24f2",
        // "0xed2e5ef8aac30360914808b79d9c07565dbaad2b",
        // "0xacd9acd5a985972b76a61eef886e20552b76af7c",
        // "0x624fd4f9a45598349ace80bc9405840d951b4456",
        // "0xa7c542018a9ed6028a38dab7ea0fbc89aa240e19",
        // "0xd7544e32014f4d0ad77bf5084c8cbd2321b7a930",
        // "0x4b38466ea1e72cb6c2912b5e669c1570adb8ac7a",
        // "0x0de0fc798339022bbb42f5f653daa6ef05b341cd",
        // "0xa54cf8845ab2f560bf9aeb6e2d1648a69d4c6529",
        // "0x3af6e4903d7eb6a88ba5ee41f2281d1221ba3928",
        // "0xb95eead438cc2d01a0c4c6f784b658ab770348ee",
    ]

    const amounts = [
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 1,
        // 2,
        // 2,
        // 2,
        // 2,
        // 2,
        // 2,
        // 3,
        // 3,
        // 3,
        // 3,
        // 3,
        // 3,
        // 3,
        // 3,
        // 4,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 5,
        // 6,
        // 6,
        // 7,
        // 7,
        // 7,
        // 7,
        // 8,
        // 8,
        // 8,
        // 8,
        // 9,
        // 9,
        // 10,
        // 10,
        // 10,
        // 10,
        // 10,
        // 10,
        // 11,
        // 11,
        // 12,
        // 12,
        // 12,
        // 12,
        // 12,
        // 12,
        // 13,
        // 14,
        // 15,
        // 15,
        // 16,
        // 17,
        // 20,
        // 20,
        // 20,
        // 20,
        // 21,
        // 21,
        // 21,
        // 22,
        // 23,
        // 25,
        // 26,
        // 26,
    ]

    // console.log("adding whitelist...");
    // const tx = await nftContract.setWhiteListsWithMaximumAmount(addresses, amounts);
    // await tx.wait()
    // console.log("done");

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
