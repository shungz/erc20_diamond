// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

interface IErc20Cut {
    enum FacetCutAction {Add, Replace, Remove}

    struct FacetCut {
        address facetAddress;
        FacetCutAction action;
        bytes4[] functionSelectors;
    }

    function erc20cut(
        FacetCut[] calldata _erc20Cut,
        address _init,
        bytes calldata _calldata
    
     ) external;

    event Erc20Cut(FacetCut[] _erc20Cut, address _init, bytes _calldata);
}
