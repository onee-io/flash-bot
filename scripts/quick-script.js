require('dotenv').config()

// 引入 ether.js 包
const ethers = require('ethers');

// 连接节点
let provider = new ethers.providers.JsonRpcProvider(process.env.POLYGON_URL);
let wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

// 手动指定交易参数
var options = { 
    gasPrice: ethers.utils.parseUnits("31", "gwei"),
    // gasLimit: 300000,
    // value: ethers.utils.parseUnits("0.01", "ether"),
    // nonce: 385
};

// 代币授权
async function approve(tokenAddress, spenderAddress) {
    // 加载代币合约
    let abi = ["function approve(address spender, uint256 amount) external returns (bool)"];
    let contract = new ethers.Contract(tokenAddress, abi, wallet);
    let allowance = ethers.BigNumber.from("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
    const tx = await contract.approve(spenderAddress, allowance, options);
    console.log("授权请求已提交 待区块链确认 tx => ", tx);
    // 等待打包
    await tx.wait();
    console.log("代币授权完成");
}

// 多路由兑换
async function executeSwap(flashBotAddress, amountIn, path, router) {
    // 加载机器人合约
    let abi = [{
        "inputs": [
          {
            "components": [
              {
                "internalType": "uint256",
                "name": "amountIn",
                "type": "uint256"
              },
              {
                "internalType": "address[]",
                "name": "path",
                "type": "address[]"
              },
              {
                "internalType": "address[]",
                "name": "router",
                "type": "address[]"
              }
            ],
            "internalType": "struct IFlashBot.SwapParam",
            "name": "param",
            "type": "tuple"
          }
        ],
        "name": "executeSwap",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      }];
    let contract = new ethers.Contract(flashBotAddress, abi, wallet);
    let param = { amountIn, path, router };
    const tx = await contract.executeSwap(param, options);
    console.log("多路由兑换请求已提交 待区块链确认 tx => ", tx);
    // 等待打包
    await tx.wait();
    console.log("多路由兑换完成");
}

// 主函数
async function main() {
    // 合约地址
    let token0Address = "0x2791bca1f2de4661ed88a30c99a7a9449aa84174"; // USDC
    let token1Address = "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270"; // WMATIC
    let quickswapRouterAddress = "0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff";
    let sushiswapRouterAddress = "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506";
    let flashBotAddress = "0xF0798939453241ac407012855Ee80c9b043BE822";

    // 授权代币
    // await approve(token0Address, flashBotAddress);

    // 多路由兑换
    let amountIn = 100;
    let path = [token0Address, token1Address, token0Address];
    let router = [quickswapRouterAddress, sushiswapRouterAddress];
    // await executeSwap(flashBotAddress, amountIn, path, router);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });