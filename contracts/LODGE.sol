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
import "contracts/libraries/Operator.sol";
import "contracts/interfaces/IUniswapV2Factory.sol";
import "contracts/interfaces/IUniswapV2Pair.sol";
import "contracts/interfaces/IUniswapV2Router02.sol";

interface ITaxOffice {
    function calculateMainTokenTax() external view returns (uint256 taxRate);
}

contract LODGE is ERC20Burnable, Operator {
    using SafeMath for uint256;

    // tax collection
    address public taxOffice;

    // immutables
    IUniswapV2Router02 public immutable uniswapV2Router;
    address public immutable USDC;
    address public immutable PairWETH;
    address public immutable PairUSDC;

    uint256 public taxRate;

    uint256 public buyTaxRate;
    uint256 public staticTaxRate = 600;
    uint256 public dynamicTaxRate;
    bool public enableDynamicTax;
    uint256 public constant MAX_TAX_RATE = 5000;

    // whitelist from and too fee
    mapping(address => bool) public whitelist;

    mapping(address => bool) public automatedMarketMakerPairs;

    event SetAutomatedMarketMakerPair(address indexed pair, bool indexed value);

    event SwapAndLiquify(uint256 tokensSwapped, uint256 ethReceived, uint256 tokensIntoLiqudity);

    constructor(address _USDC, address _router) ERC20("wildbase.farm", "2WILDX") {
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
    }

    // set whitelist
    function setWhiteList(address _WhiteList) public onlyOperator {
        require(isContract(_WhiteList) == true, "only contracts can be whitelisted");
        require(
            address(uniswapV2Router) != _WhiteList,
            "set tax to 0 if you want to remove fee from trading"
        );
        require(PairWETH != _WhiteList, "set tax to 0 if you want to remove fee from trading");
        require(PairUSDC != _WhiteList, "set tax to 0 if you want to remove fee from trading");

        whitelist[_WhiteList] = true;
    }

    function mint(address to, uint256 amount) external onlyOperator {
        super._mint(to, amount);
    }

    function isContract(address _addr) private view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_addr)
        }
        return (size > 0);
    }

    function setTaxRate(uint256 _taxRate) public onlyOperator {
        require(_taxRate <= MAX_TAX_RATE, "taxrate has to be between 0% and 50%");
        taxRate = _taxRate;
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

    function getCurrentTaxRate() public returns (uint256) {
        taxRate = staticTaxRate;
        if (enableDynamicTax == true) {
            _updateDynamicTaxRate();
            if (dynamicTaxRate > MAX_TAX_RATE) {
                dynamicTaxRate = MAX_TAX_RATE;
            }
            taxRate = dynamicTaxRate;
        }
        return taxRate;
    }

    function setStaticTaxRate(uint256 _taxRate) external onlyOperator {
        require(_taxRate <= MAX_TAX_RATE, "Error: Max tax rate exceeded.");
        staticTaxRate = _taxRate;
    }

    function setEnableDynamicTax(bool _enableDynamicTax) external onlyOperator {
        enableDynamicTax = _enableDynamicTax;
    }

    function _updateDynamicTaxRate() internal {
        dynamicTaxRate = ITaxOffice(taxOffice).calculateMainTokenTax();
    }

    function _setAutomatedMarketMakerPair(address pair, bool value) private {
        require(
            automatedMarketMakerPairs[pair] != value,
            "LEVEL: Automated market maker pair is already set to that value"
        );
        automatedMarketMakerPairs[pair] = value;

        emit SetAutomatedMarketMakerPair(pair, value);
    }

    function setTaxOffice(address _taxOffice) external onlyOperator {
        require(_taxOffice != address(0), "Error: Zero address");
        taxOffice = _taxOffice;
    }
}
