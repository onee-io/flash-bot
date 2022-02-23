// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import "@openzeppelin/contracts/utils/Address.sol";
import '../interfaces/IUniswapV2Pair.sol';

/**
 * @title 安全调用外部合约，防止异常导致revert
 */
library SafeCall {
    
    using Address for address;

    /**
     * @notice 查询账户代币余额
     * @param tokenAddress 代币合约地址
     * @param account 钱包地址
     */
    function balanceOf(address tokenAddress, address account) internal view returns (uint256) {
        if (!tokenAddress.isContract()) {
            return 0;
        }
        try IERC20Metadata(tokenAddress).balanceOf(account) returns(uint256 value) {
            return value;
        } catch {
            return 0;
        }
    }

    /**
     * @notice 查询账户代币授权额度
     * @param tokenAddress 代币合约地址
     * @param account 钱包地址
     * @param spender 授权地址
     */
    function allowance(address tokenAddress, address account, address spender) internal view returns (uint256) {
        if (!tokenAddress.isContract()) {
            return 0;
        }
        try IERC20Metadata(tokenAddress).allowance(account, spender) returns(uint256 value) {
            return value;
        } catch {
            return 0;
        }
    }

    /**
     * @notice 查询代币名称
     * @param tokenAddress 代币合约地址
     */
    function name(address tokenAddress) internal view returns (string memory) {
        if (!tokenAddress.isContract()) {
            return '';
        }
        try IERC20Metadata(tokenAddress).name() returns(string memory value) {
            return value;
        } catch {
            return '';
        }
    }

    /**
     * @notice 查询代币符号
     * @param tokenAddress 代币合约地址
     */
    function symbol(address tokenAddress) internal view returns (string memory) {
        if (!tokenAddress.isContract()) {
            return '';
        }
        try IERC20Metadata(tokenAddress).symbol() returns(string memory value) {
            return value;
        } catch {
            return '';
        }
    }

    /**
     * @notice 查询代币精度
     * @param tokenAddress 代币合约地址
     */
    function decimals(address tokenAddress) internal view returns (uint8) {
        if (!tokenAddress.isContract()) {
            return 18;
        }
        try IERC20Metadata(tokenAddress).decimals() returns(uint8 value) {
            return value;
        } catch {
            return 18;
        }
    }

    /**
     * @notice 查询代币总供应量
     * @param tokenAddress 代币合约地址
     */
    function totalSupply(address tokenAddress) internal view returns (uint256) {
        if (!tokenAddress.isContract()) {
            return 0;
        }
        try IERC20Metadata(tokenAddress).totalSupply() returns(uint256 value) {
            return value;
        } catch {
            return 0;
        }
    }

    /**
     * @notice 查询 UniswapV2 币对 token0 代币合约地址
     * @param pairAddress UniswapV2 币对合约
     */
    function token0(address pairAddress) internal view returns (address) {
        if (!pairAddress.isContract()) {
            return address(0);
        }
        try IUniswapV2Pair(pairAddress).token0() returns(address value) {
            return value;
        } catch {
            return address(0);
        }
    }

    /**
     * @notice 查询 UniswapV2 币对 token1 代币合约地址
     * @param pairAddress UniswapV2 币对合约
     */
    function token1(address pairAddress) internal view returns (address) {
        if (!pairAddress.isContract()) {
            return address(0);
        }
        try IUniswapV2Pair(pairAddress).token1() returns(address value) {
            return value;
        } catch {
            return address(0);
        }
    }

    /**
     * @notice 查询 UniswapV2 币对合约储备量
     * @param pairAddress UniswapV2 币对合约
     */
    function getReserves(address pairAddress) 
        internal 
        view 
        returns (uint112, uint112, uint32) 
    {
        if (!pairAddress.isContract()) {
            return (0, 0, 0);
        }
        try IUniswapV2Pair(pairAddress).getReserves() returns(uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast) {
            return (reserve0, reserve1, blockTimestampLast);
        } catch {
            return (0, 0, 0);
        }
    }
}