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

    before(async function () {
        // 部署机器人合约
        let FlashBot = await ethers.getContractFactory("FlashBot");
        flashBot = await FlashBot.deploy();
        await flashBot.deployed();
        // 加载测试账户地址
        [owner, addr1, ...addrs] = await ethers.getSigners();
    });

    it("getPairInfo", async function () {
        let quickswapFactory = "0x5757371414417b8C6CAad45bAeF941aBc7d3Ab32";
        let pairInfo = await flashBot.getPairInfo(quickswapFactory, 683);
        console.log("pairInfo => ", pairInfo);
        expect(pairInfo.pairAddress).to.equal("0xd899e25F21222ABE4E6212a7aDb26190B5976268");
        expect(pairInfo.token0Address).to.equal("0x55BeE1bD3Eb9986f6d2d963278de09eE92a3eF1D");
        expect(pairInfo.token1Address).to.equal("0xF6Ad3CcF71Abb3E12beCf6b3D2a74C963859ADCd");
        expect(pairInfo.token0Symbol).to.equal("TT01");
        expect(pairInfo.token1Symbol).to.equal("TT02");
    });

    it("batchPairInfo", async function () {
        let quickswapFactory = "0x5757371414417b8C6CAad45bAeF941aBc7d3Ab32";
        let pairInfoList = await flashBot.batchPairInfo(quickswapFactory, 1, 3);
        console.log("pairInfoList => ", pairInfoList);
        expect(pairInfoList.length).to.equal(3);
        // check index 1
        expect(pairInfoList[0].pairAddress).to.equal("0xbB60D1f9cbAeFA6845bf635db23Ea25a27A11E83");
        expect(pairInfoList[0].token0Address).to.equal("0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270");
        expect(pairInfoList[0].token1Address).to.equal("0x55BeE1bD3Eb9986f6d2d963278de09eE92a3eF1D");
        expect(pairInfoList[0].token0Symbol).to.equal("WMATIC");
        expect(pairInfoList[0].token1Symbol).to.equal("TT01");
        // check index 3
        expect(pairInfoList[2].pairAddress).to.equal("0x853Ee4b2A13f8a742d64C8F088bE7bA2131f670d");
        expect(pairInfoList[2].token0Address).to.equal("0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174");
        expect(pairInfoList[2].token1Address).to.equal("0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619");
        expect(pairInfoList[2].token0Symbol).to.equal("USDC");
        expect(pairInfoList[2].token1Symbol).to.equal("WETH");
    });

    it("computeSwapAmountsOut", async function () {
        let param = {
            amountIn: 10**15,
            path: [
                "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270", // WETH
                "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174", // USDC
                "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270" // WETH
            ],
            router: [
                "0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff", // QuickSwap
                "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506" // SushiSwap
            ]
        }
        let amounts = await flashBot.computeSwapAmountsOut(param);
        console.log("amounts => ", amounts);
    });

    it("computeSwapAmountOut", async function () {
        let param = {
            amountIn: 10**15,
            path: [
                "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270", // WMATIC
                "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174", // USDC
                "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270" // WMATIC
            ],
            router: [
                "0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff", // QuickSwap
                "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506" // SushiSwap
            ]
        }
        let amountOut = await flashBot.computeSwapAmountOut(param);
        console.log("amountIn => ", param.amountIn);
        console.log("amountOut => ", amountOut);
    });

    it("batchSwapAmountOut", async function () {
        let param1 = {
            amountIn: 10**10,
            path: [
                "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270", // WMATIC
                "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174", // USDC
                "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270" // WMATIC
            ],
            router: [
                "0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff", // QuickSwap
                "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506" // SushiSwap
            ]
        }
        let param2 = {
            amountIn: 10**15,
            path: [
                "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270", // WMATIC
                "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174", // USDC
                "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270" // WMATIC
            ],
            router: [
                "0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff", // QuickSwap
                "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506" // SushiSwap
            ]
        }
        let paramList = [param1, param2];
        let amountOutList = await flashBot.batchSwapAmountOut(paramList);
        console.log("amountOut[0] => ", amountOutList[0]);
        console.log("amountOut[1] => ", amountOutList[1]);
    });

    it("executeSwap", async function () {
        console.log("钱包地址 => ", owner.address);
        console.log("钱包余额 => ", await owner.getBalance());
        let privateKey = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80";
        let wallet = new ethers.Wallet(privateKey, owner.provider);
        // 加载 WMATIC 合约
        let wrapperAddress = "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270";
        let abi = [
            "function balanceOf(address account) external view returns (uint256)",
            "function approve(address spender, uint256 amount) external returns (bool)",
            "function allowance(address owner, address spender) external view returns (uint256)"
        ];
        let wmatic = new ethers.Contract(wrapperAddress, abi, wallet);
        let ownerBalance = await wmatic.balanceOf(owner.address);
        console.log("初始 WMATIC 余额 => ", ownerBalance);
        // 兑换初始 WMATIC
        let amountIn = 10**15;
        if (ownerBalance < amountIn) {
            let transaction = {
                to: wrapperAddress,
                value: amountIn - ownerBalance
            }
            await owner.sendTransaction(transaction);
            ownerBalance = await wmatic.balanceOf(owner.address);
            console.log("补齐 WMATIC 余额 => ", ownerBalance);
        }
        // 授权代币给机器人合约
        await wmatic.approve(flashBot.address, amountIn);
        let allowance = await wmatic.allowance(owner.address, flashBot.address);
        console.log("授权给机器人合约额度 => ", allowance);
        // 计算预计兑换后余额
        let param = {
            amountIn: amountIn,
            path: [
                "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270", // WMATIC
                "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174", // USDC
                "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270" // WMATIC
            ],
            router: [
                "0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff", // QuickSwap
                "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506" // SushiSwap
            ]
        }
        let amountOut = await flashBot.computeSwapAmountOut(param);
        console.log("预计兑换后 WMATIC 数量 => ", amountOut);
        // 执行兑换
        await flashBot.executeSwap(param);
        ownerBalance = await wmatic.balanceOf(owner.address);
        console.log("兑换后 WMATIC 数量 => ", ownerBalance);
        expect(amountOut).to.equal(ownerBalance);
    });

});
