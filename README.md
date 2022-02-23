# Flash Bot 🤖️

闪电交易机器人，通过合约在一笔交易中完成多个 DEX 之间搬砖套利。

参考机器人: [https://cn.etherscan.com/address/0x5aa3393e361c2eb342408559309b3e873cd876d6](https://cn.etherscan.com/address/0x5aa3393e361c2eb342408559309b3e873cd876d6)

## 部署信息

- Polygon: [0xF0798939453241ac407012855Ee80c9b043BE822](https://polygonscan.com/address/0xF0798939453241ac407012855Ee80c9b043BE822)

## 功能支持

- [x] 查询 UniswapV2 类协议流动池信息（getPairInfo）
- [x] 批量查询 UniswapV2 类协议流动池信息（batchPairInfo）
- [x] 计算 UniswapV2 类协议多路由**每步**兑换数量（computeSwapAmountsOut）
- [x] 计算 UniswapV2 类协议多路由**最终**兑换数量（computeSwapAmountOut）
- [x] 批量计算 UniswapV2 类协议多路由**最终**兑换结果（batchSwapAmountOut）
- [x] 执行 UniswapV2 类协议多路由兑换（executeSwap）
- [x] 执行 UniswapV2 类协议多路由套利兑换（executeArbitrageSwap）

## 类 UniswapV2 交易所清单

> 数据来源于 DODO 和 DeBank

### Polygon

|  交易所   | Router  | Factory |
|   ----   |   ----  |  ----   |
| QuickSwap  | [0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff](https://polygonscan.com/address/0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff) | [0x5757371414417b8c6caad45baef941abc7d3ab32](https://polygonscan.com/address/0x5757371414417b8c6caad45baef941abc7d3ab32) |
| SushiSwap  | [0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506](https://polygonscan.com/address/0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506) | [0xc35DADB65012eC5796536bD9864eD8773aBc74C4](https://polygonscan.com/address/0xc35DADB65012eC5796536bD9864eD8773aBc74C4) |
| ComethSwap  | [0x93bcDc45f7e62f89a8e901DC4A0E2c6C427D9F25](https://polygonscan.com/address/0x93bcDc45f7e62f89a8e901DC4A0E2c6C427D9F25) | [0x800b052609c355cA8103E06F022aA30647eAd60a](https://polygonscan.com/address/0x800b052609c355cA8103E06F022aA30647eAd60a) |

## 闪电贷资金清单

### Polygon

|  资金来源   | 手续费  | 接入文档 |
|   ----   |   ----  |  ----   |
| AAVE | 0.09% | - |
| UniswapV2 类协议 | 0.25% | - |
| DODO | - | [Document](https://dodoex.github.io/docs/zh/docs/flashSwap) |