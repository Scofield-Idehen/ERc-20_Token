// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManuelToken{

    mapping(address => uint256) private s_balance;
    function ScofieldToken() public pure returns(string memory){
        return "Manuel Token";
    }

    function totalsupply() public pure returns (uint256){
        return 100 ether;
    }

    function decimal() public pure returns (uint8){
        return 18;
    }

    function balanceOf(address _owner) public view returns(uint256){
        return s_balance[_owner];
    } 

}