// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;
library LibERC20 {
    bytes32 constant ERC20_STORAGE_POSITION = keccak256("diamond.standard.erc20.storage");


    struct ERC20Storage {
    string name;
    string symbol;
    uint8 decimals;
    uint256 totalSupply;
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;
       
        mapping(bytes4 => bool) supportedInterfaces;
        address contractOwner;
    }

    function erc20Storage() internal pure returns (ERC20Storage storage es) {
        bytes32 position = ERC20_STORAGE_POSITION;
        assembly {
            es.slot := position
        }
    }

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function setContractOwner(address _newOwner) internal {
        ERC20Storage storage es = erc20Storage();
        address previousOwner = es.contractOwner;
        es.contractOwner = _newOwner;
        emit OwnershipTransferred(previousOwner, _newOwner);
    }

    function contractOwner() internal view returns (address contractOwner_) {
        contractOwner_ = erc20Storage().contractOwner;
    }

    function enforceIsContractOwner() internal view {
        require(msg.sender == erc20Storage().contractOwner, "Not owner");
        }        

        function name() internal view returns (string memory) {
    return erc20Storage().name;
}

function symbol() internal view returns (string memory) {
    return erc20Storage().symbol;
}

function decimals() internal view returns (uint8) {
    return erc20Storage().decimals;
}

function totalSupply() internal view returns (uint256) {
    return erc20Storage().totalSupply;
}

function balanceOf(address account) internal view returns (uint256) {
    return erc20Storage().balances[account];
}

function transferInternal(address from, address to, uint256 amount) internal returns (bool) {
    ERC20Storage storage es = erc20Storage();

    if(from != msg.sender) {
        require(es.allowances[from][msg.sender] >= amount,"Allowance exceeded");
        es.allowances[from][msg.sender] -= amount;
    }

    require(es.balances[from] >= amount, "Insufficient balance");
    es.balances[from] -= amount;
    es.balances[to] += amount;
    return true;
}

function approve(address spender, uint256 amount) internal returns (bool) {
    ERC20Storage storage es = erc20Storage();
    es.allowances[msg.sender][spender] = amount;
    return true;
}

function allowance(address owner, address spender) internal view returns (uint256) {
    return erc20Storage().allowances[owner][spender];
}



 }







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
 