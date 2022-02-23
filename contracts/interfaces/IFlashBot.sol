//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

/// @title 闪电机器人接口定义
interface IFlashBot {

    /// 流动池信息
    struct PairInfo {
        address pairAddress;
        address token0Address;
        address token1Address;
        string token0Symbol;
        string token1Symbol;
    }

    /**
     * @notice 查询流动池信息
     * @param factoryAddress 工厂合约地址
     * @param index 流动池索引
     */
    function getPairInfo(address factoryAddress, uint256 index) external view returns (PairInfo memory);

    /**
     * @notice 批量查询流动池信息
     * @param factoryAddress 工厂合约地址
     * @param startIndex 起始索引（含）
     * @param endIndex 结束索引（含）
     */
    function batchPairInfo(address factoryAddress, uint256 startIndex, uint256 endIndex) external view returns (PairInfo[] memory);

    /**
     * @notice 计算兑换输出金额
     * @param amountIn 输入金额
     * @param path 兑换路径
     * @param router 路由合约
     */
    function computeSwapAmountOut(uint256 amountIn, address[] memory path, address[] memory router) external view returns (uint256);
}
