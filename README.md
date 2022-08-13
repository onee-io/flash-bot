# Flash Bot 🤖️

闪电交易机器人，通过合约在一笔交易中完成多个 DEX 之间搬砖套利。

兑换路径: A Token -> B Token -> A Token

参考机器人: [0x5aa3393e361c2eb342408559309b3e873cd876d6](https://etherscan.io/address/0x5aa3393e361c2eb342408559309b3e873cd876d6)

## 部署信息

- Polygon: [0xbabac2ac0369E806F28EE7CFe1c7BF02D5f6d548](https://polygonscan.com/address/0xbabac2ac0369E806F28EE7CFe1c7BF02D5f6d548)

## 功能支持

- [x] 查询 UniswapV2 类协议流动池信息（getPairInfo）
- [x] 批量查询 UniswapV2 类协议流动池信息（batchPairInfo）
- [x] 计算 UniswapV2 类协议多路由**每步**兑换数量（computeSwapAmountsOut）
- [x] 计算 UniswapV2 类协议多路由**最终**兑换数量（computeSwapAmountOut）
- [x] 批量计算 UniswapV2 类协议多路由**最终**兑换结果（batchSwapAmountOut）
- [x] 执行 UniswapV2 类协议多路由兑换（executeSwap）
- [x] 执行 UniswapV2 类协议多路由套利兑换（executeArbitrageSwap）
- [ ] 借用闪电贷执行 UniswapV2 类协议多路由兑换（executeFlashSwap）
- [ ] 借用闪电贷执行 UniswapV2 类协议多路由套利兑换（executeArbitrageFlashSwap）

## 使用方式

1. 将 `.env_template` 改为 `.env`, 填写好私钥及节点信息；
2. 参考 [quick-script.js](./scripts/quick-script.js) 实现自己的 DEX 套利交易。

*注：执行 `executeSwap` 或 `executeArbitrageSwap` 需保证发起交易的地址有对应的 Token 并且已授权给机器人合约。

## 类 UniswapV2 交易所清单

> 数据来源于 DODO 和 DeBank
>
> `*` 不支持金额计算
>
> `#` 不确定支持闪电兑换

### Polygon

|  交易所   | Router  | Factory |
|   ----   |   ----  |  ----   |
| QuickSwap  | [0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff](https://polygonscan.com/address/0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff) | [0x5757371414417b8c6caad45baef941abc7d3ab32](https://polygonscan.com/address/0x5757371414417b8c6caad45baef941abc7d3ab32) |
| SushiSwap  | [0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506](https://polygonscan.com/address/0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506) | [0xc35DADB65012eC5796536bD9864eD8773aBc74C4](https://polygonscan.com/address/0xc35DADB65012eC5796536bD9864eD8773aBc74C4) |
| ComethSwap  | [0x93bcDc45f7e62f89a8e901DC4A0E2c6C427D9F25](https://polygonscan.com/address/0x93bcDc45f7e62f89a8e901DC4A0E2c6C427D9F25) | [0x800b052609c355cA8103E06F022aA30647eAd60a](https://polygonscan.com/address/0x800b052609c355cA8103E06F022aA30647eAd60a) |
| Dfyn | [0xA102072A4C07F06EC3B4900FDC4C7B80b6c57429](https://polygonscan.com/address/0xA102072A4C07F06EC3B4900FDC4C7B80b6c57429) | [0xE7Fb3e833eFE5F9c441105EB65Ef8b261266423B](https://polygonscan.com/address/0xE7Fb3e833eFE5F9c441105EB65Ef8b261266423B)|
| WaultSwap | [0x3a1D87f206D12415f5b0A33E786967680AAb4f6d](https://polygonscan.com/address/0x3a1D87f206D12415f5b0A33E786967680AAb4f6d) | [0xa98ea6356A316b44Bf710D5f9b6b4eA0081409Ef](https://polygonscan.com/address/0xa98ea6356A316b44Bf710D5f9b6b4eA0081409Ef)|
| ApeSwap | [0xC0788A3aD43d79aa53B09c2EaCc313A787d1d607](https://polygonscan.com/address/0xC0788A3aD43d79aa53B09c2EaCc313A787d1d607) | [0xCf083Be4164828f00cAE704EC15a36D711491284](https://polygonscan.com/address/0xCf083Be4164828f00cAE704EC15a36D711491284)|
| JetSwap | [0x5C6EC38fb0e2609672BDf628B1fD605A523E5923](https://polygonscan.com/address/0x5C6EC38fb0e2609672BDf628B1fD605A523E5923) | [0x668ad0ed2622C62E24f0d5ab6B6Ac1b9D2cD4AC7](https://polygonscan.com/address/0x668ad0ed2622C62E24f0d5ab6B6Ac1b9D2cD4AC7)|
| Gravity | [0x57dE98135e8287F163c59cA4fF45f1341b680248](https://polygonscan.com/address/0x57dE98135e8287F163c59cA4fF45f1341b680248) | [0x3ed75AfF4094d2Aaa38FaFCa64EF1C152ec1Cf20](https://polygonscan.com/address/0x3ed75AfF4094d2Aaa38FaFCa64EF1C152ec1Cf20)|
| #DinoSwap | [0x6AC823102CB347e1f5925C634B80a98A3aee7E03](https://polygonscan.com/address/0x6AC823102CB347e1f5925C634B80a98A3aee7E03) | [0x624Ccf581371F8A4493e6AbDE46412002555A1b6](https://polygonscan.com/address/0x624Ccf581371F8A4493e6AbDE46412002555A1b6)|
| Polycat | [0x94930a328162957FF1dd48900aF67B5439336cBD](https://polygonscan.com/address/0x94930a328162957FF1dd48900aF67B5439336cBD) | [0x477Ce834Ae6b7aB003cCe4BC4d8697763FF456FA](https://polygonscan.com/address/0x477Ce834Ae6b7aB003cCe4BC4d8697763FF456FA)|
| Elk | [0xf38a7A7Ac2D745E2204c13F824c00139DF831FFf](https://polygonscan.com/address/0xf38a7A7Ac2D745E2204c13F824c00139DF831FFf) | [0xE3BD06c7ac7E1CeB17BdD2E5BA83E40D1515AF2a](https://polygonscan.com/address/0xE3BD06c7ac7E1CeB17BdD2E5BA83E40D1515AF2a)|
| #TetuSwap | [0x736FD9EabB15776A3adfea1B975c868F72A29d14](https://polygonscan.com/address/0x736FD9EabB15776A3adfea1B975c868F72A29d14) | [0x684d8c187be836171a1Af8D533e4724893031828](https://polygonscan.com/address/0x684d8c187be836171a1Af8D533e4724893031828)|
| #Smartdex | [0x6f5fE5Fef0186f7B27424679cbb17e45df6e2118](https://polygonscan.com/address/0x6f5fE5Fef0186f7B27424679cbb17e45df6e2118) | [0xBE087BeD88539d28664c9998FE3f180ea7b9749C](https://polygonscan.com/address/0xBE087BeD88539d28664c9998FE3f180ea7b9749C)|
| CafeSwap | [0x9055682E58C74fc8DdBFC55Ad2428aB1F96098Fc](https://polygonscan.com/address/0x9055682E58C74fc8DdBFC55Ad2428aB1F96098Fc) | [0x5eDe3f4e7203Bf1F12d57aF1810448E5dB20f46C](https://polygonscan.com/address/0x5eDe3f4e7203Bf1F12d57aF1810448E5dB20f46C)|
| *Polydex | [0xC60aE14F2568b102F8Ca6266e8799112846DD088](https://polygonscan.com/address/0xC60aE14F2568b102F8Ca6266e8799112846DD088) | [0xEAA98F7b5f7BfbcD1aF14D0efAa9d9e68D82f640](https://polygonscan.com/address/0xEAA98F7b5f7BfbcD1aF14D0efAa9d9e68D82f640)|

## 闪电贷资金清单

### Polygon

|  资金来源   | 手续费  | 接入文档 |
|   ----   |   ----  |  ----   |
| AAVE | 0.09% | - |
| Balancer | - | - |
| UniswapV2 类协议 | 0.3% | [https://www.jianshu.com/p/b715e065603e](https://www.jianshu.com/p/b715e065603e) |
| DODO | - | [https://dodoex.github.io/docs/zh/docs/flashSwap](https://dodoex.github.io/docs/zh/docs/flashSwap) |