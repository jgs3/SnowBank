/**
 *Submitted for verification at basescan.org on 2023-10-03
*/

/**
 *Submitted for verification at basescan.org on 2023-09-19
*/

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

// Part: ITaxOffice

interface ITaxOffice {
    function setMainTokenOracle(address _mainTokenOracle) external;

    function setMainTokenTaxTiers(
        uint256[] calldata _mainTokenTaxTwapTiers,
        uint256[] calldata _mainTokenTaxRateTiers
    ) external;

    function setShareTokenTaxTiers(
        uint256[] calldata _shareTokenTaxTwapTiers,
        uint256[] calldata _shareTokenTaxRateTiers
    ) external;

    function calculateMainTokenTax() external view returns (uint256 taxRate);

    function calculateShareTokenTax() external view returns (uint256 taxRate);

    function handleMainTokenTax(uint256 _amount) external;

    function handleShareTokenTax(uint256 _amount) external;

    function taxDiscount(
        address _sender,
        address _recipient
    ) external returns (uint256);
}

// Part: IBoardroom

interface IBoardroom {
    function balanceOf(address _member) external view returns (uint256);

    function earned(address _member) external view returns (uint256);

    function canWithdraw(address _member) external view returns (bool);

    function canClaimReward(address _member) external view returns (bool);

    function epoch() external view returns (uint256);

    function nextEpochPoint() external view returns (uint256);

    function getToastPrice() external view returns (uint256);

    function setOperator(address _operator) external;

    function setLockUp(
        uint256 _withdrawLockupEpochs,
        uint256 _rewardLockupEpochs
    ) external;

    function stake(uint256 _amount) external;

    function stakeFor(address recipient, uint256 amount) external;

    function withdraw(uint256 _amount) external;

    function exit() external;

    function claimReward() external;

    function allocateSeigniorage(uint256 _amount) external;

    function governanceRecoverUnsupported(
        address _token,
        uint256 _amount,
        address _to
    ) external;

    function setPermittedUser(address _user, bool _isPermitted) external;

    function share() external returns (address);

    function toast() external returns (address);

    function totalSupply() external view returns (uint256);
}

// Part: IBoardroomManager

interface IBoardroomManager {
    function stakeShare(uint256 _amount) external;

    function stakeShareFor(address _recipient, uint256 _amount) external;

    function stakeLP(uint256 _amount) external;

    function stakeLPFor(address _recipient, uint256 _amount) external;
}

// Part: IStrategyManager

interface IStrategyManager {
    function operators(address addr) external returns (bool);

    function performanceFee() external returns (uint256);

    function performanceFeeBountyPct() external returns (uint256);

    function stakedTokens(
        uint256 pid,
        address user
    ) external view returns (uint256);

    function deposit(uint256 _pid, uint256 _depositAmount) external;

    function depositFor(
        uint256 _pid,
        uint256 _depositAmount,
        address _for
    ) external;
}

// Part: IRewardPool

interface IRewardPool {
    function depositFor(
        uint256 _pid,
        uint256 _amount,
        address _recipient
    ) external;
}

// Part: IWETH
interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}
// Part: IUniswapV2Pair

interface IUniswapV2Pair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(
        address to
    ) external returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

// Part: IUniswapV2Router

interface IUniswapV2Router {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    )
        external
        payable
        returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function swapTokensForExactETH(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapETHForExactTokens(
        uint amountOut,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function quote(
        uint amountA,
        uint reserveA,
        uint reserveB
    ) external pure returns (uint amountB);

    function getAmountOut(
        uint amountIn,
        uint reserveIn,
        uint reserveOut
    ) external pure returns (uint amountOut);

    function getAmountIn(
        uint amountOut,
        uint reserveIn,
        uint reserveOut
    ) external pure returns (uint amountIn);

    function getAmountsOut(
        uint amountIn,
        address[] calldata path
    ) external view returns (uint[] memory amounts);

    function getAmountsIn(
        uint amountOut,
        address[] calldata path
    ) external view returns (uint[] memory amounts);

    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}
library PancakeLibrary {
    using SafeMath for uint;

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'PancakeLibrary: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'PancakeLibrary: ZERO_ADDRESS');
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(uint(keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'57224589c67f3f30a6b0d7a1b54cf3153ab84563bc609ef41dfb34f8b2974d2d' // init code hash
            ))));
    }

    // fetches and sorts the reserves for a pair
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
        (address token0,) = sortTokens(tokenA, tokenB);
        pairFor(factory, tokenA, tokenB);
        (uint reserve0, uint reserve1,) = IUniswapV2Pair(pairFor(factory, tokenA, tokenB)).getReserves();
        (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, 'PancakeLibrary: INSUFFICIENT_AMOUNT');
        require(reserveA > 0 && reserveB > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) internal pure returns (uint amountOut) {
        require(amountIn > 0, 'PancakeLibrary: INSUFFICIENT_INPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
        uint amountInWithFee = amountIn.mul(9975);
        uint numerator = amountInWithFee.mul(reserveOut);
        uint denominator = reserveIn.mul(10000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) internal pure returns (uint amountIn) {
        require(amountOut > 0, 'PancakeLibrary: INSUFFICIENT_OUTPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
        uint numerator = reserveIn.mul(amountOut).mul(10000);
        uint denominator = reserveOut.sub(amountOut).mul(9975);
        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    function getAmountsOut(address factory, uint amountIn, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'PancakeLibrary: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[0] = amountIn;
        for (uint i; i < path.length - 1; i++) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i], path[i + 1]);
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    function getAmountsIn(address factory, uint amountOut, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'PancakeLibrary: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint i = path.length - 1; i > 0; i--) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i - 1], path[i]);
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
}
// Part: openzeppelin/openzeppelin-contracts@3.2.0/Address

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(
        address target,
        bytes memory data,
        uint256 weiValue,
        string memory errorMessage
    ) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: weiValue}(
            data
        );
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

// Part: openzeppelin/openzeppelin-contracts@3.2.0/Context

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// Part: openzeppelin/openzeppelin-contracts@3.2.0/IERC20

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

// Part: openzeppelin/openzeppelin-contracts@3.2.0/ReentrancyGuard

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() internal {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}

// Part: openzeppelin/openzeppelin-contracts@3.2.0/SafeMath

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// Part: IERC20Taxable

interface IERC20Taxable is IERC20 {
    function taxOffice() external returns (address);

    function getCurrentTaxRate() external returns (uint256);
}

// Part: openzeppelin/openzeppelin-contracts@3.2.0/Ownable

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// Part: openzeppelin/openzeppelin-contracts@3.2.0/SafeERC20

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transfer.selector, to, value)
        );
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transferFrom.selector, from, to, value)
        );
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.approve.selector, spender, value)
        );
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(
            value
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(
                token.approve.selector,
                spender,
                newAllowance
            )
        );
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(
            value,
            "SafeERC20: decreased allowance below zero"
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(
                token.approve.selector,
                spender,
                newAllowance
            )
        );
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(
            data,
            "SafeERC20: low-level call failed"
        );
        if (returndata.length > 0) {
            // Return data is optional
            // solhint-disable-next-line max-line-length
            require(
                abi.decode(returndata, (bool)),
                "SafeERC20: ERC20 operation did not succeed"
            );
        }
    }
}

// Part: MultipleOperator

contract MultipleOperator is Context, Ownable {
    mapping(address => bool) private _operator;

    event OperatorStatusChanged(
        address indexed _operator,
        bool _operatorStatus
    );

    constructor() internal {
        _operator[_msgSender()] = true;
        _operator[address(this)] = true;
        emit OperatorStatusChanged(_msgSender(), true);
    }

    modifier onlyOperator() {
        require(
            _operator[msg.sender] == true,
            "operator: caller is not the operator"
        );
        _;
    }

    function isOperator() public view returns (bool) {
        return _operator[_msgSender()];
    }

    function isOperator(address _account) public view returns (bool) {
        return _operator[_account];
    }

    function setOperatorStatus(
        address _account,
        bool _operatorStatus
    ) public onlyOwner {
        _setOperatorStatus(_account, _operatorStatus);
    }

    function setOperatorStatus(
        address[] memory _accounts,
        bool _operatorStatus
    ) external onlyOperator {
        for (uint8 idx = 0; idx < _accounts.length; ++idx) {
            _setOperatorStatus(_accounts[idx], _operatorStatus);
        }
    }

    function setShareTokenWhitelistType(
        address[] memory _accounts,
        bool[] memory _operatorStatuses
    ) external onlyOperator {
        require(
            _accounts.length == _operatorStatuses.length,
            "Error: Account and OperatorStatuses lengths not equal"
        );
        for (uint8 idx = 0; idx < _accounts.length; ++idx) {
            _setOperatorStatus(_accounts[idx], _operatorStatuses[idx]);
        }
    }

    function _setOperatorStatus(
        address _account,
        bool _operatorStatus
    ) internal {
        _operator[_account] = _operatorStatus;
        emit OperatorStatusChanged(_account, _operatorStatus);
    }
}

// Part: ZapBase

contract ZapBase is MultipleOperator, ReentrancyGuard {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    /* ========== CONSTANT VARIABLES ========== */

    uint256 public constant BASIS_POINTS_DENOM = 10_000;

    /* ========== STATE VARIABLES ========== */

    address public WETH;
    address public mainToken;
    address public mainTokenLP;
    address public shareToken;
    address public shareTokenLP;

    uint256 public taxRateRatio;

    IUniswapV2Router private ROUTER;
    address PancakeSwapFactory;
    address feeAddress = address(0xAE02196968A374A2d1281eD082F7A66b510FA8aD);
    mapping(address => bool) public excludedAddresses;

    enum TokenType {
        INVALID,
        ERC20,
        LP
    }
    mapping(address => TokenType) public tokenType; //Type of token @ corresponding address.
    mapping(address => mapping(address => address[])) public swapPath; // Paths for swapping 2 given tokens.

    event TaxPaid(address indexed user, uint256 amount);
    event AddLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountInA,
        uint256 amountInB,
        uint256 amountOut
    );
    event SwapTokens(
        address tokenA,
        address tokenB,
        uint256 amountInA,
        uint256 amountOut
    );

    /* ========== CONSTRUCTOR ========== */

    function setCoreValues(
        address _router,
        address factory,
        address _mainToken,
        address _mainTokenLP,
        address _shareToken,
        address _shareTokenLP,
        address _weth
    ) external onlyOwner {
        mainToken = _mainToken;
        mainTokenLP = _mainTokenLP;
        shareToken = _shareToken;
        shareTokenLP = _shareTokenLP;
        WETH = _weth;
        PancakeSwapFactory = factory;
        ROUTER = IUniswapV2Router(_router);

        tokenType[WETH] = TokenType.ERC20;
        tokenType[mainToken] = TokenType.ERC20;
        tokenType[mainTokenLP] = TokenType.LP;
        tokenType[shareToken] = TokenType.ERC20;
        tokenType[shareTokenLP] = TokenType.LP;
    }

    receive() external payable {}

    /* ========== EXTERNAL FUNCTIONS ========== */

    function zap(
        address _inputToken,
        uint256 _amount,
        address _targetToken,
        bool _targetIsNative
    ) external returns (uint256 amountOut) {
        amountOut = _universalZap(
            _inputToken, //_inputToken
            _amount, //_amount
            _targetToken, //_targetToken
            msg.sender, //_recipient
            _targetIsNative
        );
    }

    /* ========== EXTERNAL FUNCTIONS ========== */

    function zapETH(
        address _targetToken
    ) external payable returns (uint256 amountOut) {
        amountOut = _universalZapETH(
            msg.value, //_amount
            _targetToken, //_targetToken
            msg.sender //_recipient
        );
    }

    function addTaxFreeLiquidity(
        address _tokenA,
        address _tokenB,
        uint256 _amountA,
        uint256 _amountB
    ) external {
        IERC20(_tokenA).safeTransferFrom(msg.sender, address(this), _amountA);
        IERC20(_tokenB).safeTransferFrom(msg.sender, address(this), _amountB);

        _increaseRouterAllowance(_tokenA, _amountA);
        _increaseRouterAllowance(_tokenB, _amountB);

        ROUTER.addLiquidity(
            _tokenA,
            _tokenB,
            _amountA,
            _amountB,
            _amountA.mul(95).div(100),
            _amountB.mul(95).div(100),
            msg.sender,
            block.timestamp + 40
        );
    }

    function removeTaxFreeLiquidity(
        address _tokenA,
        address _tokenB,
        address _pair,
        uint256 _amount
    ) external {
        IERC20(_pair).safeTransferFrom(msg.sender, address(this), _amount);

        _increaseRouterAllowance(_pair, _amount);

        (uint256 _amountA, uint256 _amountB) = ROUTER.removeLiquidity(
            _tokenA,
            _tokenB,
            _amount,
            0,
            0,
            address(this),
            block.timestamp + 40
        );

        IERC20(_tokenA).transfer(msg.sender, _amountA);
        IERC20(_tokenB).transfer(msg.sender, _amountB);
    }

    /* ========== MAIN ZAP FUNCTION ========== */

    function _zapIntoTokenTaxWrapper(
        address _inputToken,
        uint256 _amount,
        address _targetToken,
        bool _targetIsNative,
        address _recipient
    ) internal returns (uint256 amountOut) {
        //Handle token taxes - Only if not zapping into farm.
        //Zap into token.
        if (_targetIsNative == true) {
            amountOut = _zapIntoETH(
                _inputToken,
                _amount,
                _recipient
            );
        } else {
            amountOut = _zapIntoToken(
                _inputToken,
                _amount,
                _targetToken,
                _recipient
            );
        }
    }
    /**
        @notice Zaps in ERC20 tokens to LP tokens.
    */
    function _zapIntoETH(
        address _inputToken,
        uint256 _amount,
        address _recipient
    ) internal returns (uint256 amountOut) {
        require(
            tokenType[_inputToken] == TokenType.ERC20,
            "Error: Invalid token type"
        );
        //Safely increase the router allowance.
        _increaseRouterAllowance(_inputToken, _amount);

        amountOut = _swapTokensForETH(
                    _amount, //_amountIn,
                    _inputToken, //_pathIn,
                    _recipient //_recipient,
                );
    }
    /**
        @notice Zaps in ERC20 tokens to LP tokens.
    */
    function _zapIntoToken(
        address _inputToken,
        uint256 _amount,
        address _targetToken,
        address _recipient
    ) internal returns (uint256 amountOut) {
        require(
            tokenType[_inputToken] == TokenType.ERC20,
            "Error: Invalid token type"
        );
        require(
            tokenType[_targetToken] != TokenType.INVALID,
            "Error: Invalid token type"
        );

        //Safely increase the router allowance.
        _increaseRouterAllowance(_inputToken, _amount);

        //If target token is an LP token.
        if (tokenType[_targetToken] == TokenType.LP) {
            //Deconstruct target token.
            IUniswapV2Pair pair = IUniswapV2Pair(_targetToken);
            address token0 = pair.token0();
            address token1 = pair.token1();

            //Input token is a component of the target LP token then swap half and add liquidity.
            if (_inputToken == token0 || _inputToken == token1) {
                //Dictate which is the missing LP token.
                address missingToken = _inputToken == token0 ? token1 : token0;
                uint256 altTokenAmount = _amount.div(2);

                amountOut = _zapIntoLPFromComponentToken(
                    _inputToken, // _componentToken
                    _inputToken, // _altToken
                    _amount.sub(altTokenAmount), //_componentTokenAmount
                    altTokenAmount, //_altTokenAmount
                    missingToken, //_missingToken
                    _recipient //_recipient
                );

                //Otherwise swap the token for ETH and then add the liquidity from there.
            } else {
                uint256 ethAmount = _swapTokensForETH(
                    _amount, //_amountIn,
                    _inputToken, //_pathIn,
                    address(this) //_recipient,
                );

                //Truncate eth balance to account for tax.
                uint256 ethBalance = address(this).balance;
                ethAmount = ethAmount > ethBalance ? ethBalance : ethAmount;

                amountOut = _swapETHToLP(
                    _targetToken, //lpToken
                    ethAmount, //amount
                    _recipient //_recipient.
                );
            }
            //Otherwise swap tokens for tokens.
        } else {
            amountOut = _swapTokensForTokens(
                _amount, //_amountIn
                _inputToken, //_pathIn
                _targetToken, //_pathOut
                _recipient //_recipient
            );
        }
    }

    function _zapIntoLPFromComponentToken(
        address _componentToken,
        address _altToken,
        uint256 _componentTokenAmount,
        uint256 _altTokenAmount,
        address _missingToken,
        address _recipient
    ) internal returns (uint256 amountOut) {
        //Swap alternative token to missing token.
        _increaseRouterAllowance(_altToken, _altTokenAmount);
        uint256 _missingTokenAmount = _swapTokensForTokens(
            _altTokenAmount, //_amountIn
            _altToken, //_pathIn
            _missingToken, //_pathOut
            address(this) //_recipient
        );

        //Increase router allowances.
        _increaseRouterAllowance(_componentToken, _componentTokenAmount);
        _increaseRouterAllowance(_missingToken, _missingTokenAmount);

        //Add liquidity
        (, , amountOut) = ROUTER.addLiquidity(
            _componentToken,
            _missingToken,
            _componentTokenAmount,
            _missingTokenAmount,
            0,
            0,
            _recipient,
            block.timestamp + 40
        );

        //Emit event - Dont need to truncate as we send straight to recipient from the router.
        emit AddLiquidity(
            _componentToken,
            _missingToken,
            _componentTokenAmount,
            _missingTokenAmount,
            amountOut
        );
    }
    
    
    function _unZapIntoETH(
        address _inputToken,
        uint256 _amount,
        address _recipient
    ) internal returns (uint256 amountOut) {
        //Deconstruct target token.
        IUniswapV2Pair pair = IUniswapV2Pair(_inputToken);
        address tokenA = pair.token0();
        address tokenB = pair.token1();

        //Remove Liquidity.
        _increaseRouterAllowance(_inputToken, _amount);
        (uint256 amountA, uint256 amountB) = ROUTER.removeLiquidity(
            tokenA, //tokenA
            tokenB, //tokenB
            _amount, //liquidity
            0, //amountAMin
            0, //amountBMin
            address(this), //recipient
            block.timestamp + 40 //deadline
        );

        //Swap tokenA to target token if required.
        if (tokenA != WETH) {
            amountA = _swapTokensForTokens(
                amountA, //_amountIn
                tokenA, //_pathIn
                WETH, //_pathOut
                address(this) //_recipient
            );
            IWETH(WETH).deposit{value: amountA}();
            IERC20(WETH).transfer(_recipient, amountA);
        } else {
            IWETH(WETH).deposit{value: amountA}();
            IERC20(WETH).transfer(_recipient, amountA);
        }

        //Swap tokenB to target token if required.
        if (tokenB != WETH) {
            amountB = _swapTokensForTokens(
                amountB, //_amountIn
                tokenB, //_pathIn
                WETH, //_pathOut
                address(this) //_recipient
            );
            IWETH(WETH).deposit{value: amountB}();
            IERC20(WETH).transfer(_recipient, amountB);
        } else {
            IWETH(WETH).deposit{value: amountB}();
            IERC20(WETH).transfer(_recipient, amountB);
        }

        //Add amount out.
        amountOut = amountA.add(amountB);
    }

    function _unZapIntoToken(
        address _inputToken,
        uint256 _amount,
        address _targetToken,
        address _recipient
    ) internal returns (uint256 amountOut) {
        require(
            tokenType[_inputToken] == TokenType.LP,
            "Error: Invalid token type"
        );
        require(
            tokenType[_targetToken] == TokenType.ERC20,
            "Error: Invalid token type"
        );

        //Restrict usage if not an operator.
        if (!isOperator()) {
            require(
                _targetToken == mainToken || _targetToken == shareToken,
                "Error: User is not an operator"
            );
        }

        //Deconstruct target token.
        IUniswapV2Pair pair = IUniswapV2Pair(_inputToken);
        address tokenA = pair.token0();
        address tokenB = pair.token1();

        //Remove Liquidity.
        _increaseRouterAllowance(_inputToken, _amount);
        (uint256 amountA, uint256 amountB) = ROUTER.removeLiquidity(
            tokenA, //tokenA
            tokenB, //tokenB
            _amount, //liquidity
            0, //amountAMin
            0, //amountBMin
            address(this), //recipient
            block.timestamp + 40 //deadline
        );

        //Swap tokenA to target token if required.
        if (tokenA != _targetToken) {
            amountA = _swapTokensForTokens(
                amountA, //_amountIn
                tokenA, //_pathIn
                _targetToken, //_pathOut
                _recipient //_recipient
            );
        } else {
            IERC20(_targetToken).transfer(_recipient, amountA);
        }

        //Swap tokenB to target token if required.
        if (tokenB != _targetToken) {
            amountB = _swapTokensForTokens(
                amountB, //_amountIn
                tokenB, //_pathIn
                _targetToken, //_pathOut
                _recipient //_recipient
            );
        } else {
            IERC20(_targetToken).transfer(_recipient, amountB);
        }

        //Add amount out.
        amountOut = amountA.add(amountB);
    }

    function _unZapIntoLP(
        address _inputToken,
        uint256 _amount,
        address _targetToken,
        address _recipient
    ) internal returns (uint256 amountOut) {
        require(
            tokenType[_inputToken] == TokenType.LP,
            "Error: Invalid token type"
        );
        require(
            tokenType[_targetToken] == TokenType.LP,
            "Error: Invalid token type"
        );

        //Restrict usage if not an operator.
        if (!isOperator()) {
            require(
                _targetToken == mainTokenLP || _targetToken == shareTokenLP,
                "Error: User is not an operator"
            );
        }

        //Deconstruct target token.
        IUniswapV2Pair pair = IUniswapV2Pair(_inputToken);
        address inputTokenA = pair.token0();
        address inputTokenB = pair.token1();

        //Remove Liquidity.
        _increaseRouterAllowance(_inputToken, _amount);
        (uint256 amountA, uint256 amountB) = ROUTER.removeLiquidity(
            inputTokenA, //tokenA
            inputTokenB, //tokenB
            _amount, //liquidity
            0, //amountAMin
            0, //amountBMin
            address(this), //recipient
            block.timestamp + 40 //deadline
        );

        //Get output token components.
        pair = IUniswapV2Pair(_targetToken);
        address outputTokenA = pair.token0();
        address outputTokenB = pair.token1();

        //If input token A is already a component.
        if (inputTokenA == outputTokenA || inputTokenA == outputTokenB) {
            //Dictate which is the missing LP token.
            address missingToken = inputTokenA == outputTokenA
                ? outputTokenB
                : outputTokenA;
            amountOut = _zapIntoLPFromComponentToken(
                inputTokenA, //_componentToken,
                inputTokenB, //_altToken,
                amountA, //_componentTokenAmount,
                amountB, //_altTokenAmount,
                missingToken, //_missingToken,
                _recipient
            );
            //If input token A is already a component.
        } else if (inputTokenB == outputTokenA || inputTokenB == outputTokenB) {
            //Dictate which is the missing LP token.
            address missingToken = inputTokenB == outputTokenA
                ? outputTokenB
                : outputTokenA;
            amountOut = _zapIntoLPFromComponentToken(
                inputTokenB, //_componentToken,
                inputTokenA, //_altToken,
                amountB, //_componentTokenAmount,
                amountA, //_altTokenAmount,
                missingToken, //_missingToken,
                _recipient
            );
            //Otherwise swap both tokens to ETH and then convert to LP.
        } else {
            //Swap both tokens to ETH.
            uint256 ethAmountA = _swapTokensForETH(
                amountA, //_amountIn,
                inputTokenA, //_pathIn,
                address(this) //_recipient,
            );
            uint256 ethAmountB = _swapTokensForETH(
                amountB, //_amountIn,
                inputTokenB, //_pathIn,
                address(this) //_recipient,
            );

            //Convert eth to LP.
            amountOut = _swapETHToLP(
                _targetToken, //lpToken
                ethAmountA.add(ethAmountB), //amount
                _recipient //_recipient.
            );
        }
    }

    function _universalZap(
        address _inputToken,
        uint256 _amount,
        address _targetToken,
        address _recipient,
        bool _targetIsNative
    ) internal returns (uint256 amountOut) {
        require(
            tokenType[_inputToken] != TokenType.INVALID,
            "Error: Invalid token type"
        );
        require(
            tokenType[_targetToken] != TokenType.INVALID,
            "Error: Invalid token type"
        );

        //Transfer token into contract.
        IERC20(_inputToken).safeTransferFrom(
            msg.sender,
            address(this),
            _amount
        );

        //Exit early if no zap required.
        if (_inputToken == _targetToken) {
            if (_recipient != address(this)) {
                IERC20(_inputToken).safeTransfer(_recipient, _amount);
            }
            return _amount;
        }

        //Zap into token.
        if (tokenType[_inputToken] == TokenType.ERC20) {
            if (_inputToken == WETH && _targetIsNative) {
                IWETH(WETH).deposit{value: _amount}();
                IERC20(WETH).transfer(_recipient, _amount);
            } else {
                amountOut = _zapIntoTokenTaxWrapper(
                    _inputToken,
                    _amount,
                    _targetToken,
                    _targetIsNative,
                    _recipient
                );
            }
        } else if (tokenType[_targetToken] == TokenType.ERC20) {
            if (_targetIsNative) {
                amountOut = _unZapIntoETH(
                    _inputToken,
                    _amount,
                    _recipient
                );
            } else {
                amountOut = _unZapIntoToken(
                    _inputToken,
                    _amount,
                    _targetToken,
                    _recipient
                );
            }
        } else {
            amountOut = _unZapIntoLP(
                _inputToken,
                _amount,
                _targetToken,
                _recipient
            );
        }

        //Truncate to target token balance.
        uint256 targetTokenBalance = IERC20(_targetToken).balanceOf(_recipient);
        amountOut = amountOut > targetTokenBalance
            ? targetTokenBalance
            : amountOut;
    }

    function _universalZapETH(
        uint256 _amount,
        address _targetToken,
        address _recipient
    ) internal returns (uint256 amountOut) {
        require(
            tokenType[_targetToken] != TokenType.INVALID,
            "Error: Invalid token type"
        );
        //Zap into token.
        if (tokenType[_targetToken] == TokenType.ERC20) {
            if (_targetToken == WETH) {
                IWETH(WETH).deposit{value: _amount}();
                IERC20(WETH).transfer(_recipient, _amount);
            } else {
               amountOut = _swapETHForTokens(_amount, _targetToken, _recipient);
            }
        } else {
            amountOut = _swapETHToLP(
                mainTokenLP,
                _amount,
                _recipient
            );
        }

        //Truncate to target token balance.
        uint256 targetTokenBalance = IERC20(_targetToken).balanceOf(_recipient);
        amountOut = amountOut > targetTokenBalance
            ? targetTokenBalance
            : amountOut;
    }

    /* ========== Private Functions ========== */

    function _swapETHToLP(
        address _lpToken,
        uint256 _amount,
        address _recipient
    ) internal returns (uint256 amountOut) {
        //If target token is not an LP then perform single swap.
        if (tokenType[_lpToken] == TokenType.LP) {
            //Deconstruct LP token.
            IUniswapV2Pair pair = IUniswapV2Pair(_lpToken);
            address token0 = pair.token0();
            address token1 = pair.token1();

            //If either of the tokens are WETH then swap half of the EVMOS balance.
            if (token0 == WETH || token1 == WETH) {
                address altToken = token0 == WETH ? token1 : token0;
                uint256 swapValue = _amount.div(2);

                uint256 altTokenAmount = _swapETHForTokens(
                    swapValue, //_amountIn
                    altToken, //_pathOut
                    address(this) //_recipient
                );

                _increaseRouterAllowance(altToken, altTokenAmount);

                (, , amountOut) = ROUTER.addLiquidityETH{
                    value: _amount.sub(swapValue)
                }(
                    altToken,
                    altTokenAmount,
                    0,
                    0,
                    _recipient,
                    block.timestamp + 40
                );
                emit AddLiquidity(
                    WETH,
                    altToken,
                    _amount.sub(swapValue),
                    altTokenAmount,
                    amountOut
                );

                //Otherwise perform 2 swaps & add liquidity.
            } else {
                uint256 swapValue = _amount.div(2);
                uint256 token0Amount = _swapETHForTokens(
                    swapValue, //_amountIn
                    token0, //_pathOut
                    address(this) //_recipient
                );
                uint256 token1Amount = _swapETHForTokens(
                    _amount.sub(swapValue), //_amountIn
                    token1, //_pathOut
                    address(this) //_recipient
                );

                _increaseRouterAllowance(token0, token0Amount);
                _increaseRouterAllowance(token1, token1Amount);

                (, , amountOut) = ROUTER.addLiquidity(
                    token0,
                    token1,
                    token0Amount,
                    token1Amount,
                    0,
                    0,
                    _recipient,
                    block.timestamp + 40
                );
                emit AddLiquidity(
                    token0,
                    token1,
                    token0Amount,
                    token1Amount,
                    amountOut
                );
            }
        }
    }

    /* ========== SWAP FUNCTIONS ========== */

    function _increaseRouterAllowance(address _token, uint256 _amount) private {
        IERC20(_token).safeIncreaseAllowance(address(ROUTER), _amount);
    }

    function _setSwapPath(
        address _token0,
        address _token1,
        address[] memory _path
    ) internal virtual {
        require(_path.length > 1, "Error: Path is not long enough.");
        require(
            _path[0] == _token0 && _path[_path.length - 1] == _token1,
            "Error: Endpoints of path are incorrect."
        );
        swapPath[_token0][_token1] = _path;

        //Set inverse path.
        uint256 pathLength = _path.length;
        address[] memory invPath = new address[](pathLength);
        for (uint256 i = 0; i < pathLength; i++) {
            invPath[i] = _path[pathLength - 1 - i];
        }
        swapPath[_token1][_token0] = invPath;
    }

    function setSwapPath(
        address _token0,
        address _token1,
        address[] calldata _path
    ) external virtual onlyOwner {
        _setSwapPath(_token0, _token1, _path);
    }

    /**
        @notice Swaps Tokens for Tokens Safely. - Is public to allow a static call.
    */
    function _swapTokensForTokens(
        uint256 _amountIn,
        address _pathIn,
        address _pathOut,
        address _recipient
    ) internal returns (uint256 _outputAmount) {
        //Extract swap path.
        address[] memory path = swapPath[_pathIn][_pathOut];
        if (path.length == 0) {
            path = new address[](2);
            path[0] = _pathIn;
            path[1] = _pathOut;
        }

        //Increase allowance and swap.
        if (_amountIn > 0) {
            _increaseRouterAllowance(_pathIn, _amountIn);
            if (_pathIn == mainToken || _pathIn == shareToken) {
                (address token0,) = PancakeLibrary.sortTokens(_pathIn, _pathOut);
                IUniswapV2Pair pair = IUniswapV2Pair(PancakeLibrary.pairFor(PancakeSwapFactory, _pathIn, _pathOut));
                uint amountOutput;
                { // scope to avoid stack too deep errors
                (uint reserve0, uint reserve1,) = pair.getReserves();
                (uint reserveInput, uint reserveOutput) = _pathIn == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
                amountOutput = PancakeLibrary.getAmountOut(_amountIn, reserveInput, reserveOutput);
                }
                _outputAmount =amountOutput;
                ROUTER.swapExactTokensForTokensSupportingFeeOnTransferTokens(
                    _amountIn,
                    0,
                    path,
                    _recipient,
                    block.timestamp + 40
                );
            } else {
                uint256[] memory amounts = ROUTER.swapExactTokensForTokens(
                    _amountIn,
                    0,
                    path,
                    _recipient,
                    block.timestamp + 40
                );
                _outputAmount = amounts[amounts.length - 1];
            }
        }

        emit SwapTokens(_pathIn, _pathOut, _amountIn, _outputAmount);
    }

    /**
        @notice Swaps Tokens for 'ETH' safely. 
    */
    function _swapTokensForETH(
        uint256 _amountIn,
        address _pathIn,
        address _recipient
    ) internal returns (uint256 _outputAmount) {
        //Set output of the path.
        address _pathOut = WETH;

        //Extract swap path.
        address[] memory path = swapPath[_pathIn][_pathOut];
        if (path.length == 0) {
            path = new address[](2);
            path[0] = _pathIn;
            path[1] = _pathOut;
        }

        //Increase allowance and swap.
        if (_amountIn > 0) {
            _increaseRouterAllowance(_pathIn, _amountIn);
            if (_pathIn == mainToken || _pathIn == shareToken) {
                (address token0,) = PancakeLibrary.sortTokens(_pathIn, _pathOut);
                IUniswapV2Pair pair = IUniswapV2Pair(PancakeLibrary.pairFor(PancakeSwapFactory, _pathIn, _pathOut));
                uint amountOutput;
                { // scope to avoid stack too deep errors
                    (uint reserve0, uint reserve1,) = pair.getReserves();
                    (uint reserveInput, uint reserveOutput) = _pathIn == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
                    amountOutput = PancakeLibrary.getAmountOut(_amountIn, reserveInput, reserveOutput);
                }
                ROUTER.swapExactTokensForETHSupportingFeeOnTransferTokens(
                    _amountIn,
                    0,
                    path,
                    _recipient,
                    block.timestamp + 40
                );
                _outputAmount = amountOutput;
            } else {
                uint256[] memory amounts = ROUTER.swapExactTokensForETH(
                    _amountIn,
                    0,
                    path,
                    _recipient,
                    block.timestamp + 40
                );
                _outputAmount = amounts[amounts.length - 1];
            }
        }

        emit SwapTokens(_pathIn, _pathOut, _amountIn, _outputAmount);
    }

    /**
        @notice Swaps 'ETH' for Tokens safely. 
    */
    function _swapETHForTokens(
        uint256 _amountIn,
        address _pathOut,
        address _recipient
    ) internal returns (uint256 _outputAmount) {
        //Set output of the path.
        address _pathIn = WETH;

        //Extract swap path.
        address[] memory path = swapPath[_pathIn][_pathOut];
        if (path.length == 0) {
            path = new address[](2);
            path[0] = _pathIn;
            path[1] = _pathOut;
        }

        //Increase allowance and swap.
        if (_amountIn > 0) {
            uint256[] memory amounts = ROUTER.swapExactETHForTokens{
                value: _amountIn
            }(0, path, _recipient, block.timestamp + 40);
            _outputAmount = amounts[amounts.length - 1];
        }

        emit SwapTokens(_pathIn, _pathOut, _amountIn, _outputAmount);
    }

    /* ========== EXTERNAL SWAP FUNCTIONS ========== */

    function swapTokensForTokens(
        uint256 _amountIn,
        address _pathIn,
        address _pathOut,
        address _recipient
    ) external onlyOperator returns (uint256 _outputAmount) {
        IERC20(_pathIn).transferFrom(msg.sender, address(this), _amountIn);
        _outputAmount = _swapTokensForTokens(
            _amountIn,
            _pathIn,
            _pathOut,
            _recipient
        );
    }

    function swapETHForTokens(
        uint256 _amountIn,
        address _pathOut,
        address _recipient
    ) external payable onlyOperator returns (uint256 _outputAmount) {
        require(
            msg.value > _amountIn,
            "Zap: Not enough ether sent in for the swap"
        );
        _outputAmount = _swapETHForTokens(_amountIn, _pathOut, _recipient);
    }

    function swapTokensForETH(
        uint256 _amountIn,
        address _pathIn,
        address _recipient
    ) external onlyOperator returns (uint256 _outputAmount) {
        IERC20(_pathIn).transferFrom(msg.sender, address(this), _amountIn);
        _outputAmount = _swapTokensForETH(_amountIn, _pathIn, _recipient);
    }

    /* ========== RESTRICTED FUNCTIONS ========== */

    /**
        @notice Sets the token type of an address.
    */
    function setTokenType(address _token, uint8 _type) public onlyOwner {
        tokenType[_token] = TokenType(_type);
    }

    function setTokensType(
        address[] memory _tokens,
        uint8 _type
    ) external onlyOperator {
        for (uint8 idx = 0; idx < _tokens.length; ++idx) {
            tokenType[_tokens[idx]] = TokenType(_type);
        }
    }

    function setTokensTypes(
        address[] memory _tokens,
        uint8[] memory _types
    ) external onlyOperator {
        require(
            _tokens.length == _types.length,
            "Error: Tokens and Types lengths not equal"
        );
        for (uint8 idx = 0; idx < _tokens.length; ++idx) {
            tokenType[_tokens[idx]] = TokenType(_types[idx]);
        }
    }

    function setTaxRateRatio(uint256 _taxRateRatio) external onlyOwner {
        taxRateRatio = _taxRateRatio;
    }

    function withdraw(address token) external onlyOwner {
        if (token == address(0)) {
            payable(owner()).transfer(address(this).balance);
            return;
        }
        IERC20(token).transfer(owner(), IERC20(token).balanceOf(address(this)));
    }

    function withdrawETH() external onlyOwner {
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }
    function setExcludedAddress(
        address _account,
        bool _isExcluded
    ) external onlyOwner {
        excludedAddresses[_account] = _isExcluded;
    }
}

// File: ZapV3.sol

contract ZapV3 is ZapBase {
    event ZapIntoFarm(
        address indexed _recipient,
        uint256 indexed _pid,
        uint256 _amount
    );
    event ZapIntoAC(
        address indexed _recipient,
        uint256 indexed _pid,
        uint256 _amount
    );
    event ZapIntoBoardroom(
        address indexed _recipient,
        address _inputToken,
        uint256 _amount
    );
    event ZapIntoBoardrooms(
        address indexed _recipient,
        uint256 _lpAmount,
        uint256 _ssAmount
    );

    /* ========== BANK ========== */

    function zapIntoFarmWithToken(
        address _inputToken,
        uint256 _amount,
        address _targetToken,
        address _farm,
        uint256 _pid,
        bool _targetIsNative
    ) external nonReentrant returns (uint256 amountOut) {
        //Zap into token.
        amountOut = _universalZap(
            _inputToken, //_inputToken
            _amount, //_amount
            _targetToken, //_targetToken
            address(this), //_recipient
            _targetIsNative
        );

        //Stake in farm.
        IERC20(_targetToken).safeIncreaseAllowance(_farm, amountOut);
        IRewardPool(_farm).depositFor(_pid, amountOut, msg.sender);

        //Emit event.
        emit ZapIntoFarm(msg.sender, _pid, amountOut);
    }

    /* ========== BANK ========== */

    function zapIntoFarmWithETH(
        address _targetToken,
        address _farm,
        uint256 _pid
    ) external payable nonReentrant returns (uint256 amountOut) {
        //Zap into token.
        require(msg.value > 0, "Insufficient ETH");

        amountOut = _universalZapETH(
            msg.value, //_amount
            _targetToken, //_targetToken
            address(this) //_recipient
        );

        //Stake in farm.
        IERC20(_targetToken).safeIncreaseAllowance(_farm, amountOut);
        IRewardPool(_farm).depositFor(_pid, amountOut, msg.sender);

        //Emit event.
        emit ZapIntoFarm(msg.sender, _pid, amountOut);
    }
    /* ========== AUTOCOMPOUNDER ========== */

    function zapIntoACWithToken(
        address _inputToken,
        uint256 _amount,
        address _targetToken,
        address _strategyManager,
        uint256 _pid,
        bool _targetIsNative
    ) external nonReentrant returns (uint256 amountOut) {
        //Zap into token.
        amountOut = _universalZap(
            _inputToken, //_inputToken
            _amount, //_amount
            _targetToken, //_targetToken
            address(this), //_recipient
            _targetIsNative
        );

        //Stake in farm.
        IERC20(_targetToken).safeIncreaseAllowance(_strategyManager, amountOut);
        IStrategyManager(_strategyManager).depositFor(
            _pid,
            amountOut,
            msg.sender
        );

        //Emit event.
        emit ZapIntoAC(msg.sender, _pid, amountOut);
    }

    /* ========== BOARDROOM ========== */

    function zapIntoBoardroomWithToken(
        address _inputToken,
        uint256 _amount,
        address _boardroom,
        bool _targetIsNative
    ) external nonReentrant returns (uint256 amountOut) {
        //Obtain target token.
        address _targetToken = IBoardroom(_boardroom).share();

        //Zap into token.
        amountOut = _universalZap(
            _inputToken, //_inputToken
            _amount, //_amount
            _targetToken, //_targetToken
            address(this), //_recipient
            _targetIsNative
        );

        //Stake in boardroom.
        IERC20(_targetToken).safeIncreaseAllowance(_boardroom, amountOut);
        IBoardroom(_boardroom).stakeFor(msg.sender, amountOut);

        //Emit event.
        emit ZapIntoBoardroom(msg.sender, _targetToken, amountOut);
    }

    /* ========== BOARDROOM MANAGER ========== */

    function zapIntoBoardroomsWithToken(
        address _inputToken,
        uint256 _amount,
        uint256 _lpRatio,
        address _boardroomManager,
        bool _targetIsNative
    ) external {
        require(
            _lpRatio <= BASIS_POINTS_DENOM,
            "BoardroomZap: LP ratio too high"
        );

        //Calculate input amounts.
        uint256 lpInputAmount = _amount.mul(_lpRatio).div(BASIS_POINTS_DENOM);
        uint256 ssInputAmount = _amount.sub(lpInputAmount);

        //Zap and stake into LP boardroom.
        uint256 lpAmountStaked;
        if (lpInputAmount > 0) {
            lpAmountStaked = _universalZap(
                _inputToken, //_inputToken
                lpInputAmount, //_amount
                shareTokenLP, //_targetToken
                address(this), //_recipient
                _targetIsNative
            );
            IERC20(shareTokenLP).safeIncreaseAllowance(
                address(_boardroomManager),
                lpAmountStaked
            );
            IBoardroomManager(_boardroomManager).stakeLPFor(
                msg.sender,
                lpAmountStaked
            );
        }

        //Zap and stake into SS boardroom.
        uint256 ssAmountStaked;
        if (ssInputAmount > 0) {
            ssAmountStaked = _universalZap(
                _inputToken, //_inputToken
                ssInputAmount, //_amount
                shareToken, //_targetToken
                address(this), //_recipient
                _targetIsNative
            );
            IERC20(shareToken).safeIncreaseAllowance(
                address(_boardroomManager),
                ssAmountStaked
            );
            IBoardroomManager(_boardroomManager).stakeShareFor(
                msg.sender,
                ssAmountStaked
            );
        }

        //Emit event.
        emit ZapIntoBoardrooms(msg.sender, lpAmountStaked, ssAmountStaked);
    }
}