//SPDX-License-Identifier:MIT
pragma solidity ^0.8.26;


import { LibERC20 }  from "contracts/libraries/Liberc20.sol";


contract ERC20Facet {

    
    function name() external view returns (string memory) {
        return LibERC20.erc20Storage().name;
    }

    function symbol() external view returns (string memory) {
        return LibERC20.erc20Storage().symbol;
}

function decimals() external view returns (uint8) {
        return uint8(LibERC20.erc20Storage().decimals);
    }

    function totalSupply() external view returns (uint256) {
            return LibERC20.erc20Storage().totalSupply;
}

function balanceOf(address account) external view returns (uint256) {
        return LibERC20.erc20Storage().balances[account];
    }

    function transfer(address to, uint256 amount) external returns (bool) {
      return LibERC20.transferInternal(msg.sender, to, amount);
       
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        LibERC20.ERC20Storage storage es = LibERC20.erc20Storage();
        es.allowances[msg.sender][spender] = amount;
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return LibERC20.erc20Storage().allowances[owner][spender];
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
     return LibERC20.transferInternal(from, to, amount);   
    }

}
 