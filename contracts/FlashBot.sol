//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

import "./interfaces/IFlashBot.sol";
import "./interfaces/IUniswapV2Factory.sol";
import "./interfaces/IUniswapV2Pair.sol";

/// @title 闪电机器人接口实现
contract FlashBot is IFlashBot {

    /// @inheritdoc IFlashBot
    function getPairInfo(address factoryAddress, uint256 index)
        external
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
}
