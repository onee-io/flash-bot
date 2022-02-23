//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

/// @title 闪电机器人接口定义
interface IFlashBot {

    /**
     * 流动池信息
     */
    struct PairInfo {
        // 流动池合约
        address pairAddress;
        // token0 合约
        address token0Address;
        // token1 合约
        address token1Address;
        // token0 代币符号
        string token0Symbol;
        // token1 代币符号
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
     * 兑换参数
     */
    struct SwapParam {
        // 输入金额
        uint256 amountIn;
        // 兑换路径
        address[] path;
        // 路由合约
        address[] router;
    }

    /**
     * @notice 计算多路由兑换数量
     * @param param 兑换参数
     */
    function computeSwapAmountsOut(SwapParam calldata param) external view returns (uint256[] memory);

    /**
     * @notice 计算多路由兑换最终输出金额
     * @param param 兑换参数
     */
    function computeSwapAmountOut(SwapParam calldata param) external view returns (uint256);

    /**
     * @notice 批量计算多路由兑换最终输出金额
     * @param paramList 兑换参数列表
     */
    function batchSwapAmountOut(SwapParam[] calldata paramList) external view returns (uint256[] memory);

    /**
     * @notice 执行兑换
     * @param param 兑换参数
     */
    function executeSwap(SwapParam calldata param) external;
}
