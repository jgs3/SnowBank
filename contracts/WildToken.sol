// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

import "./pancakeSwap/interfaces/IPancakeFactory.sol";
import "./pancakeSwap/interfaces/IPancakeRouter02.sol";


contract WildToken is ERC20, Ownable, ERC20Permit, ERC20Votes {

    mapping(address => bool) public isPair;
    address public devAddress;

    uint constant MAX_SELL_TAX = 6;
    uint sellTax = 6;

    event IsPairSet(address indexed pairAddress, bool isPair);
    event DevAddressUpdated(address indexed newDevAddress);
    event SellTaxUpdated(uint newSellTax);

    modifier onlyDev() {
        require(msg.sender == devAddress, "Only dev");
        _;
    }

    constructor(address _routerAddress, address _devAddress) ERC20("wildbase.farm", "WILD") ERC20Permit("WILD") {
        devAddress = _devAddress;
        IPancakeRouter02 uniswapV2Router = IPancakeRouter02(_routerAddress);
        address WETH = uniswapV2Router.WETH();
        // Create a uniswap pair for this new token
        address pair = IPancakeFactory(uniswapV2Router.factory()).createPair(address(this), WETH);
        isPair[pair] = true;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // The following functions are overrides required by Solidity.

    function _transfer(address _from, address _to, uint256 _amount) internal override  {
        if(isPair[_to]) {
            uint taxAmount = _amount * sellTax / 100;
            super._transfer(_from, devAddress, taxAmount);
            super._transfer(_from, _to, _amount - taxAmount);
        } else {
            super._transfer(_from, _to, _amount);
        }
    }

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount) internal override(ERC20, ERC20Votes) {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount) internal override(ERC20, ERC20Votes) {
        super._burn(account, amount);
    }

    function transferDev(address _newDev) external onlyDev {
        require(_newDev != address(0), "Zero address");
        devAddress = _newDev;
        emit DevAddressUpdated(_newDev);
    }

    function setIsPair(address pair, bool _isPair) external onlyDev {
        isPair[pair] = _isPair;
        emit IsPairSet(pair, _isPair);
    }

    function setSellTax(uint _newSellTax) external onlyDev {
        require(_newSellTax <= MAX_SELL_TAX, "Too high");
        emit SellTaxUpdated(_newSellTax);
        sellTax = _newSellTax;
    }

}
