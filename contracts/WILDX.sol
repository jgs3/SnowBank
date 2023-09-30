// SPDX-License-Identifier: UNLICENSED













pragma solidity ^0.8.15;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "contracts/libraries/SafeMath8.sol";
import "contracts/interfaces/IOracle.sol";
import "contracts/interfaces/IUniswapV2Factory.sol";
import "contracts/interfaces/IUniswapV2Pair.sol";
import "contracts/interfaces/IUniswapV2Router02.sol";

contract WILDX is ERC20Burnable, Ownable {
    using SafeMath for uint256;
    // immutables
    IUniswapV2Router02 public immutable uniswapV2Router;
    address public immutable USDC;
    address public immutable PairWETH;
    address public immutable PairUSDC;

    uint256 public startTime;
    uint256 public firstTaxRate = 1200;
    uint256 public secondTaxRate = 1000;
    uint256 public thirdTaxRate = 800;
    uint256 public staticTaxRate = 600;
    uint256 public duration = 1 days;
    uint256 public constant MAX_TAX_RATE = 2000;

    // whitelist from and too fee
    mapping(address => bool) public whitelist;

    mapping(address => bool) public automatedMarketMakerPairs;

    event SetAutomatedMarketMakerPair(address indexed pair, bool indexed value);

    event SwapAndLiquify(uint256 tokensSwapped, uint256 ethReceived, uint256 tokensIntoLiqudity);

    constructor(address _USDC, address _router) ERC20("wildxbase.farm", "WILDx") {
        USDC = _USDC;
        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(_router);
        uniswapV2Router = _uniswapV2Router;

        PairWETH = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(
            address(this),
            _uniswapV2Router.WETH()
        );

        PairUSDC = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), USDC);
        _setAutomatedMarketMakerPair(PairWETH, true);
        _setAutomatedMarketMakerPair(PairUSDC, true);

        whitelist[msg.sender] = true;
        startTime = block.timestamp;
    }

    // set whitelist
    function setWhiteList(address _WhiteList) public onlyOwner {
        require(isContract(_WhiteList) == true, "only contracts can be whitelisted");
        require(
            address(uniswapV2Router) != _WhiteList,
            "set tax to 0 if you want to remove fee from trading"
        );
        require(PairWETH != _WhiteList, "set tax to 0 if you want to remove fee from trading");
        require(PairUSDC != _WhiteList, "set tax to 0 if you want to remove fee from trading");

        whitelist[_WhiteList] = true;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        super._mint(to, amount);
    }

    function isContract(address _addr) private view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_addr)
        }
        return (size > 0);
    }


    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        if (
            whitelist[sender] == true ||
            whitelist[recipient] == true ||
            automatedMarketMakerPairs[sender]
        ) {
            super._transfer(sender, recipient, amount);
        } else {
            uint256 taxAmount = amount.mul(getCurrentTaxRate()).div(10000);
            uint256 amountAfterTax = amount.sub(taxAmount);
            super.burn(taxAmount);
            _transfer(sender, recipient, amountAfterTax);
        }
        _approve(
            sender,
            _msgSender(),
            allowance(sender, _msgSender()).sub(amount, "ERC20: transfer amount exceeds allowance")
        );
        return true;
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        if (whitelist[_msgSender()] == true || whitelist[recipient] == true) {
            super._transfer(_msgSender(), recipient, amount);
        } else {
            uint256 taxAmount = amount.mul(getCurrentTaxRate()).div(10000);
            uint256 amountAfterTax = amount.sub(taxAmount);
            super.burn(taxAmount);
            _transfer(_msgSender(), recipient, amountAfterTax);
        }

        return true;
    }

    function burn(uint256 amount) public override {
        super.burn(amount);
    }

    function getCurrentTaxRate() public view returns  (uint256) {
        return _getStaticTaxRate();
    }

    function _getStaticTaxRate() private view returns (uint256) {
        if (block.timestamp - startTime > 0 && block.timestamp - startTime <= duration) {
            return firstTaxRate;
        } else if (block.timestamp - startTime > duration && block.timestamp - startTime <= 2 * duration) {
            return secondTaxRate;
        } else if (block.timestamp - startTime > 2 * duration && block.timestamp - startTime <= 3 * duration) {
            return thirdTaxRate;
        } else {
            return staticTaxRate;
        }
    }

    function _setAutomatedMarketMakerPair(address pair, bool value) private {
        require(
            automatedMarketMakerPairs[pair] != value,
            "LEVEL: Automated market maker pair is already set to that value"
        );
        automatedMarketMakerPairs[pair] = value;

        emit SetAutomatedMarketMakerPair(pair, value);
    }
}
