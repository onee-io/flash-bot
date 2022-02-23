//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

import "./interfaces/IFlashBot.sol";
import "./interfaces/IUniswapV2Factory.sol";
import "./interfaces/IUniswapV2Pair.sol";
import "./interfaces/IUniswapV2Router02.sol";

/// @title 闪电机器人接口实现
contract FlashBot is IFlashBot {

    /// @inheritdoc IFlashBot
    function getPairInfo(address factoryAddress, uint256 index)
        public
        view
        override
        returns (PairInfo memory)
    {
        address pairAddress = IUniswapV2Factory(factoryAddress).allPairs(index);
        address token0Address = IUniswapV2Pair(pairAddress).token0();
        string memory token0Symbol = IERC20Metadata(token0Address).symbol();
        address token1Address = IUniswapV2Pair(pairAddress).token1();
        string memory token1Symbol = IERC20Metadata(token1Address).symbol();
        return PairInfo({
            pairAddress: pairAddress,
            token0Address: token0Address,
            token0Symbol: token0Symbol,
            token1Address: token1Address,
            token1Symbol: token1Symbol
        });
    }

    /// @inheritdoc IFlashBot
    function batchPairInfo(address factoryAddress, uint256 startIndex, uint256 endIndex)
        external
        view
        override
        returns (PairInfo[] memory) 
    {
        require(endIndex >= startIndex, "index error");
        PairInfo[] memory pairInfoList = new PairInfo[](endIndex - startIndex + 1);
        for (uint256 i = 0; i < pairInfoList.length; i++) {
            uint256 index = i + startIndex;
            pairInfoList[i] = getPairInfo(factoryAddress, index);
        }
        return pairInfoList;
    }

    /// @inheritdoc IFlashBot
    function computeSwapAmountOut(SwapParam memory param)
        public
        view
        override
        returns (uint256)
    {
        require(param.path.length >= 2, "path error");
        require(param.path.length - 1 == param.router.length, "router error");
        // 计算兑换金额
        uint256 _amountIn = param.amountIn;
        uint256 _amountOut = 0;
        for (uint256 i = 0; i < param.router.length; i++) {
            address[] memory _path = new address[](2);
            _path[0] = param.path[i];
            _path[1] = param.path[i + 1];
            // 通过路由合约计算输出金额
            uint[] memory amounts = IUniswapV2Router02(param.router[i]).getAmountsOut(_amountIn, _path);
            _amountOut = amounts[amounts.length - 1];
            // 下次兑换的输入金额是本次兑换的输出金额
            _amountIn = _amountOut; 
        }
        return _amountOut;
    }

    /// @inheritdoc IFlashBot
    function batchSwapAmountOut(SwapParam[] memory paramList)
        external
        view
        override
        returns (uint256[] memory)
    {
        uint256[] memory amountOutList = new uint256[](paramList.length);
        for (uint256 i = 0; i < paramList.length; i++) {
            amountOutList[i] = computeSwapAmountOut(paramList[i]);
        }
        return amountOutList;
    }

}
