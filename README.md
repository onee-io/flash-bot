# Flash Bot 🤖️

闪电交易机器人，通过合约在一笔交易中完成多个 DEX 之间搬砖套利。

参考机器人: [https://cn.etherscan.com/address/0x5aa3393e361c2eb342408559309b3e873cd876d6](https://cn.etherscan.com/address/0x5aa3393e361c2eb342408559309b3e873cd876d6)

## 部署信息

- Polygon: [0x]()

## 功能支持

- [x] 查询 UniswapV2 类协议流动池信息（getPairInfo）
- [x] 批量查询 UniswapV2 类协议流动池信息（batchPairInfo）
- [x] 计算 UniswapV2 类协议多路由**每步**兑换数量（computeSwapAmountsOut）
- [x] 计算 UniswapV2 类协议多路由**最终**兑换数量（computeSwapAmountOut）
- [x] 批量计算 UniswapV2 类协议多路由**最钟**兑换结果（batchSwapAmountOut）
- [x] 执行 UniswapV2 类协议多路由兑换（executeSwap）
- [x] 执行 UniswapV2 类协议多路由套利兑换（executeArbitrageSwap）