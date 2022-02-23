const { expect } = require("chai");
const { ethers } = require("hardhat");

// 闪电交易机器人测试用例
// 注：需要在 fork 的 Polygon 主网执行用例
// 执行命令：hh --network localhost test
describe("FlashBot", function () {

    let flashBot;
    let owner;
    let addr1;
    let addrs;

    beforeEach(async function () {
        // 部署机器人合约
        let FlashBot = await ethers.getContractFactory("FlashBot");
        flashBot = await FlashBot.deploy();
        await flashBot.deployed();
        // 加载测试账户地址
        [owner, addr1, ...addrs] = await ethers.getSigners();
    });

    it("getPairInfo", async function () {
        let quickswapFactory = "0x5757371414417b8C6CAad45bAeF941aBc7d3Ab32";
        let pairInfo = await flashBot.getPairInfo(quickswapFactory, 0);
        // console.log("pairInfo => ", pairInfo);
        expect(pairInfo.pairAddress).to.equal("0xd899e25F21222ABE4E6212a7aDb26190B5976268");
        expect(pairInfo.token0Address).to.equal("0x55BeE1bD3Eb9986f6d2d963278de09eE92a3eF1D");
        expect(pairInfo.token1Address).to.equal("0xF6Ad3CcF71Abb3E12beCf6b3D2a74C963859ADCd");
        expect(pairInfo.token0Symbol).to.equal("TT01");
        expect(pairInfo.token1Symbol).to.equal("TT02");
    });
});
