//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

import "./interfaces/IFlashBot.sol";
import "./interfaces/IUniswapV2Factory.sol";
import "./interfaces/IUniswapV2Pair.sol";
import "./interfaces/IUniswapV2Router02.sol";
import "./libraries/UniswapV2Library.sol";
import "./libraries/SafeCall.sol";

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
        string memory token0Symbol = SafeCall.symbol(token0Address);
        address token1Address = IUniswapV2Pair(pairAddress).token1();
        string memory token1Symbol = SafeCall.symbol(token1Address);
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
        require(endIndex >= startIndex, "INDEX ERROR");
        PairInfo[] memory pairInfoList = new PairInfo[](endIndex - startIndex + 1);
        for (uint256 i = 0; i < pairInfoList.length; i++) {
            uint256 index = i + startIndex;
            pairInfoList[i] = getPairInfo(factoryAddress, index);
        }
        return pairInfoList;
    }

    /// @inheritdoc IFlashBot
    function computeSwapAmountsOut(SwapParam calldata param)
        public
        view
        override
        returns (uint256[] memory) 
    {
        require(param.path.length >= 2, "PATH ERROR");
        require(param.path.length - 1 == param.router.length, "ROUTER ERROR");
        // 计算兑换金额
        uint256[] memory _amounts = new uint256[](param.path.length);
        _amounts[0] = param.amountIn;
        for (uint256 i = 0; i < param.router.length; i++) {
            address[] memory _path = new address[](2);
            _path[0] = param.path[i];
            _path[1] = param.path[i + 1];
            // 通过路由合约计算输出金额
            uint[] memory amounts = IUniswapV2Router02(param.router[i]).getAmountsOut(_amounts[i], _path);
            _amounts[i + 1] = amounts[amounts.length - 1];
        }
        return _amounts;
    }

    /// @inheritdoc IFlashBot
    function computeSwapAmountOut(SwapParam calldata param)
        external
        view
        override
        returns (uint256)
    {
        uint256[] memory amounts = computeSwapAmountsOut(param);
        return amounts[amounts.length - 1];
    }

    /// @inheritdoc IFlashBot
    function batchSwapAmountOut(SwapParam[] calldata paramList)
        external
        view
        override
        returns (uint256[] memory)
    {
        uint256[] memory amountOutList = new uint256[](paramList.length);
        for (uint256 i = 0; i < paramList.length; i++) {
            try this.computeSwapAmountOut(paramList[i]) returns (uint256 amount) {
                amountOutList[i] = amount;
            } catch {
                amountOutList[i] = 0;
            }
        }
        return amountOutList;
    }

    /// @inheritdoc IFlashBot
    function executeSwap(SwapParam calldata param)
        external
        override
    {
        uint256[] memory amounts = computeSwapAmountsOut(param);
        _swap(amounts, param.path, param.router);
    }

    /// @inheritdoc IFlashBot
    function executeArbitrageSwap(SwapParam calldata param)
        external
        override
    {
        require(param.path.length >= 3, "PATH ERROR");
        require(param.path[0] == param.path[param.path.length - 1], "TOKEN ERROR");
        uint256[] memory amounts = computeSwapAmountsOut(param);
        // 判断回来的代币数量要大于支付的数量
        require(amounts[amounts.length - 1] > amounts[0], "NO ARBITRAGE");
        _swap(amounts, param.path, param.router);
    }

    /**
     * @notice 多路由兑换
     * @param amounts 兑换金额
     * @param path 兑换路径
     * @param router 路由合约
     */
    function _swap(uint[] memory amounts, address[] memory path, address[] memory router) internal virtual {
        // 把初始金额转入第一个流动池合约
        address pair = _getPairAddress(router[0], path[0], path[1]);
        IERC20(path[0]).transferFrom(msg.sender, pair, amounts[0]);
        // 多路由兑换
        for (uint256 i; i < router.length; i++) {
            (address input, address output) = (path[i], path[i + 1]);
            (address token0,) = UniswapV2Library.sortTokens(input, output);
            uint256 amountOut = amounts[i + 1];
            (uint256 amount0Out, uint256 amount1Out) = input == token0 ? (uint256(0), amountOut) : (amountOut, uint256(0));
            address to = i < router.length - 1 ? _getPairAddress(router[i + 1], output, path[i + 2]) : msg.sender;
            IUniswapV2Pair(_getPairAddress(router[i], input, output)).swap(
                amount0Out, amount1Out, to, new bytes(0)
            );
        }
    }

    /**
     * @notice 获取流动池合约地址
     * @param router 路由合约
     * @param token0 代币0
     * @param token1 代币1
     */
    function _getPairAddress(address router, address token0, address token1) 
        internal
        view
        returns (address)
    {
        address factory = IUniswapV2Router02(router).factory();
        return IUniswapV2Factory(factory).getPair(token0, token1);
    }
}
