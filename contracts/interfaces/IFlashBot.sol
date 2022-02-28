//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

/// @title 闪电机器人接口定义
interface IFlashBot {

    /**************************************************************************
     *                              聚合信息查询                                *
     **************************************************************************/

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
        // token0 储备量
        uint112 reserve0;
        // token1 储备量
        uint112 reserve1;
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

    /**************************************************************************
     *                                 执行套利                                *
     **************************************************************************/

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
     * @notice 执行兑换 (msg.sender 需要本金及提前授权)
     * @param param 兑换参数
     */
    function executeSwap(SwapParam calldata param) external;

    /**
     * @notice 执行套利兑换 (msg.sender 需要本金及提前授权)
     * @param param 兑换参数
     */
    function executeArbitrageSwap(SwapParam calldata param) external;

    /**
     * @notice 执行闪电兑换 (无需本金)
     * @param param 兑换参数
     */
    function executeFlashSwap(SwapParam calldata param) external;

    /**
     * @notice 执行套利闪电兑换 (无需本金)
     * @param param 兑换参数
     */
    function executeArbitrageFlashSwap(SwapParam calldata param) external;

    /**************************************************************************
     *                                   提款                                  *
     **************************************************************************/

    /**
     * @notice 合约余额提款到 owner
     */
    function withdraw() external;

    /**
     * @notice 合约余额提款到指定地址
     * @param to 接收地址
     */
    function withdrawTo(address to) external;

    /**
     * @notice 合约代币余额提款到 owner
     * @param tokens 代币列表
     */
    function withdrawToken(address[] calldata tokens) external;

    /**
     * @notice 合约代币余额提款到 owner
     * @param tokens 代币列表
     * @param to 接收地址
     */
    function withdrawToken(address[] calldata tokens, address to) external;
}
