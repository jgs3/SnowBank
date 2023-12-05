import { ethers } from "hardhat";
const utils = require("../scripts/utils");

import { config } from "./config";

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("deployer address:", deployer.address);
    // const presaleContract = await utils.deployAndVerify("WILDPresaleFork", [config.wild]);
    const presaleContract = await ethers.getContractAt("WILDPresaleFork", config.presale);


    const addresses = [
        "0xb2A056c6961b8801Eb7A0F27ee6487440c18086f",
        "0xb2a056c6961b8801eb7a0f27ee6487440c18086f",
        "0x5ee9c79317d6020958d4f07aef7940e30cf4cb9d",
        "0x31a369b76569b0008e840a665e5134ac435d66b5",
        "0xdb7efcc59e2da3f17cf8a6d6072fc32d16caa440",
        "0x8f1d8c788e15c1e8de99dce8e2d23a3a513fc62a",
        "0x7b1d3bb271aa9144a0f058553383fb0b696f441b",
        "0xdbb5cedacc86722ac44eab65fbd5fa4dc46fd8e1",
        "0x1b0b7d389c73a2c0f2ec3a6ed88da569b70194f5",
        "0x31a369b76569b0008e840a665e5134ac435d66b5",
        "0xe96e0e1ae9915c72adb8e1061bcf979e42594b13",
        "0xd6ee61efad23a1c937e9fc2d45c868a78d893b77",
        "0xd6ee61efad23a1c937e9fc2d45c868a78d893b77",
        "0xd6ee61efad23a1c937e9fc2d45c868a78d893b77",
        "0xd6ee61efad23a1c937e9fc2d45c868a78d893b77",
        "0xd6ee61efad23a1c937e9fc2d45c868a78d893b77",
        "0xd6ee61efad23a1c937e9fc2d45c868a78d893b77",
        "0x68fa0fcb53bf9794f99bee91973dfd4c50db774c",
        "0x7b1d3bb271aa9144a0f058553383fb0b696f441b",
        "0xa84bdf49e4bdd101884ea2fef6c33cd8d9e845b5",
        "0xd9c13d1badc0fe49b9eecb41299832ac42d08972",
        "0x58020bab25e6053a4c41a4eb78dfd8900ca4d7cf",
        "0xca94e791eee754dd0df39c66de79e5c3e50b2d34",
        "0x8669994d45acc7856142c923575c4e44ec6bcba5",
        "0x534ec10913f40a271cd46644a6bb54a0152916c6",
        "0x13d6eb1fefa628aaaf36b6ecac94a4e9c6a75441",
        "0xa54d94b20970bc8de0fa5f7f6f68f681113c743a",
        "0xa54d94b20970bc8de0fa5f7f6f68f681113c743a",
        "0x1a4446c2ffb3d6cf2adfe96d26cc9f326df881e1",
        "0x1a4446c2ffb3d6cf2adfe96d26cc9f326df881e1",
        "0x1a4446c2ffb3d6cf2adfe96d26cc9f326df881e1",
        "0xa9400341dd52fa54dd66200983d0898d77628297",
        "0xa54cf8845ab2f560bf9aeb6e2d1648a69d4c6529",
        "0xa54cf8845ab2f560bf9aeb6e2d1648a69d4c6529",
        "0xa54cf8845ab2f560bf9aeb6e2d1648a69d4c6529",
        "0xa54cf8845ab2f560bf9aeb6e2d1648a69d4c6529",
        "0xa19c7454dbac78e6d996833a93f897e95dc359c8",
        "0x4c8d78a40c45af71c448f35c6ad153d0a7b9651f",
        "0xbde523369d33210281e4b2fee22999166d052c48",
        "0xbde523369d33210281e4b2fee22999166d052c48",
        "0xa54d94b20970bc8de0fa5f7f6f68f681113c743a",
        "0xa03dabd794c419587996d32eae582101cdfc55f3",
        "0xa03dabd794c419587996d32eae582101cdfc55f3",
        "0xd46580816c5dd3ba602c9023f7f61fdc688ad5f9",
        "0xa54d94b20970bc8de0fa5f7f6f68f681113c743a",
        "0xd17a28a019c16ae2c27e73e7b88bddcc21e323b5",
        "0x6613d588e89553337aa00451038222812442f000",
        "0x6613d588e89553337aa00451038222812442f000",
        "0x6613d588e89553337aa00451038222812442f000",
        "0xa9400341dd52fa54dd66200983d0898d77628297",
        "0xa9400341dd52fa54dd66200983d0898d77628297",
        "0x501c2cae71d9568da1972b03f27ed2d527d20ac1",
        "0x56efcaba9013e6b47e729e4b4eab6dee09d5abc8",
        "0xa54cf8845ab2f560bf9aeb6e2d1648a69d4c6529",
        "0xedf2a9da692d98f03118d02bee242121aa629e7a",
        "0xedf2a9da692d98f03118d02bee242121aa629e7a",
        "0xa54cf8845ab2f560bf9aeb6e2d1648a69d4c6529",
        "0x8669994d45acc7856142c923575c4e44ec6bcba5",
        "0x038355d7639b2aa6795b3213e05457ab838e11ea",
        "0x038355d7639b2aa6795b3213e05457ab838e11ea",
        "0x8c845fd5ee5cf6b49bdcc04a5cc8a19c7519bdb7",
        "0x2aac0bab6fe67b147f50d8979acc922eadb76661",
        "0x4d0e73b58d823f16d9ab658bfd96afd043fb1aca",
        "0x3400c4b41041ad826737f01bb3bae31c880e3a19",
        "0x4d0e73b58d823f16d9ab658bfd96afd043fb1aca",
        "0x4d0e73b58d823f16d9ab658bfd96afd043fb1aca",
        "0x4d0e73b58d823f16d9ab658bfd96afd043fb1aca",
        "0x4d0e73b58d823f16d9ab658bfd96afd043fb1aca",
        "0x382371705d48905637dac2abf5fee537300f5d3f",
        "0x2c17150cb3055f9ed20a035f17c9212d25ae8dac",
        "0x2c17150cb3055f9ed20a035f17c9212d25ae8dac",
        "0x3849126e937b9aad4200822955e1b58f9817fe7e",
        "0x21304bbab2c32b4c3a054009a78184a67c149fae",
        "0x42317463adf62dde38b5a76b0a66a2816eee4a70",
        "0x31a369b76569b0008e840a665e5134ac435d66b5",
        "0x31a369b76569b0008e840a665e5134ac435d66b5",
        "0x4a2cdb82a0782658300f183859b30baa845a36a8",
        "0x74b29bed05623cbe43feaf22f3b862c800640c77",
        "0x74b29bed05623cbe43feaf22f3b862c800640c77",
        "0x74b29bed05623cbe43feaf22f3b862c800640c77",
        "0x4d0e73b58d823f16d9ab658bfd96afd043fb1aca",
        "0x8c845fd5ee5cf6b49bdcc04a5cc8a19c7519bdb7",
        "0xa54cf8845ab2f560bf9aeb6e2d1648a69d4c6529",
        "0x80f5c555071bb2dd29ce38f034532b5552559521",
        "0xca94e791eee754dd0df39c66de79e5c3e50b2d34",
        "0x7da23bc4a403cad82a8ffa90ccd4e15c94850443",
        "0xe793c78891c3f4fa2a62eefb48d5384b78752457",
        "0xabf371a3e7d3bdaa100f1e21eb0579641a178eef",
        "0xa54cf8845ab2f560bf9aeb6e2d1648a69d4c6529",
        "0x60eb10f386eba81edd5e5e040b0eb23b7b026873",
        "0xa54cf8845ab2f560bf9aeb6e2d1648a69d4c6529",
        "0x6ab2fdb75ae385f4178f693e670e61d271084443",
        "0x6ab2fdb75ae385f4178f693e670e61d271084443",
    ];

    const owneds = [
        "23103000000000000000",
        "2310300000000000000",
        "1910100000000000000",
        "3820300000000000000",
        "39366800000000000000",
        "200100000000000000",
        "1964700000000000000",
        "39221200000000000000",
        "82153600000000000000",
        "5857700000000000000",
        "2546800000000000000",
        "91000000000000000",
        "72800000000000000",
        "72800000000000000",
        "72800000000000000",
        "11751800000000000000",
        "3911200000000000000",
        "3911200000000000000",
        "3893000000000000000",
        "1946500000000000000",
        "9750700000000000000",
        "53683600000000000000",
        "19374100000000000000",
        "8750200000000000000",
        "9768900000000000000",
        "19501500000000000000",
        "3893000000000000000",
        "3893000000000000000",
        "194487100000000000000",
        "200100000000000000",
        "38893800000000000000",
        "19465100000000000000",
        "19410500000000000000",
        "7749700000000000000",
        "1946500000000000000",
        "964200000000000000",
        "30998600000000000000",
        "38730100000000000000",
        "54600000000000000",
        "7622300000000000000",
        "19192200000000000000",
        "109100000000000000",
        "19010300000000000000",
        "5712200000000000000",
        "3601900000000000000",
        "37893200000000000000",
        "54600000000000000",
        "54600000000000000",
        "8531900000000000000",
        "18992100000000000000",
        "37966000000000000000",
        "16117800000000000000",
        "7585900000000000000",
        "382000000000000000",
        "3765700000000000000",
        "32126500000000000000",
        "946000000000000000",
        "1328000000000000000",
        "54600000000000000",
        "11388000000000000000",
        "19028500000000000000",
        "181900000000000000",
        "1910100000000000000",
        "38147900000000000000",
        "17172900000000000000",
        "9532400000000000000",
        "9550600000000000000",
        "9550600000000000000",
        "19083100000000000000",
        "1891900000000000000",
        "1891900000000000000",
        "45424600000000000000",
        "29779800000000000000",
        "79843200000000000000",
        "7585900000000000000",
        "1891900000000000000",
        "79661300000000000000",
        "18200000000000000",
        "9441500000000000000",
        "9441500000000000000",
        "5657600000000000000",
        "18919300000000000000",
        "3783900000000000000",
        "31780800000000000000",
        "1873700000000000000",
        "27997000000000000000",
        "193959600000000000000",
        "24049400000000000000",
        "91000000000000000",
        "5512100000000000000",
        "91000000000000000",
        "36400000000000000",
        "6076000000000000000",
    ];

    console.log("adding whitelist...");
    const tx = await presaleContract.setWiLDOwned(addresses, owneds);
    await tx.wait()
    console.log("done");
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
