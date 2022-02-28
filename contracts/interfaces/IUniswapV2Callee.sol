//SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.0;

interface IUniswapV2Callee {

    /// UniswapV2
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;

    /// WalutSwap
    function waultSwapCall(address sender, uint amount0, uint amount1, bytes calldata data) external;

    /// ApwSwap
    function apeCall(address sender, uint amount0, uint amount1, bytes calldata data) external;

    /// JetSwap
    function jetswapCall(address sender, uint amount0, uint amount1, bytes calldata data) external;

    /// Elk
    function elkCall(address sender, uint amount0, uint amount1, bytes calldata data) external;

    /// CafeSwap
    function cafeCall(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
