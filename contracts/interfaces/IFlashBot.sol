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
}
