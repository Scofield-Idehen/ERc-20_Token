//SPDX-License-Identifier: MIT 
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployToken} from "../script/DeployToken.s.sol";
import {OurToken} from "../src/ourToken.sol";


contract OurTestToken is Test{
    OurToken public tk;
    DeployToken public dp;

    address bob = makeAddr("bob");
    address alice = makeAddr("Alice");

    uint256 public constant STARTING_BAL = 100 ether; 
    

    function setUp() public {
        dp = new DeployToken();
        tk = dp.run();

        vm.prank(address(msg.sender));
        tk.transfer(bob, STARTING_BAL);

    }

    function testBobBal() public {
        assertEq(STARTING_BAL, tk.balanceOf(bob));
    }

    function testBobAllow() public {
        uint initallow = 1000 ether;
        vm.prank(bob);
        tk.approve(alice, initallow);

        uint transferAmount = 500;
        vm.prank(alice);
        tk.transferFrom(bob, alice, transferAmount);
        assertEq(tk.balanceOf(alice), transferAmount);
        assertEq(tk.balanceOf(bob), STARTING_BAL- transferAmount);
    }

    function testTransferToZeroAddress() public {
    uint transferAmount = 50;
    vm.prank(bob);
    
    // Attempting to transfer to the zero address should fail, and the balance should remain unchanged.
    try tk.transfer(address(0), transferAmount) returns (bool success) {
        assertEq(success, false, "Transfer to zero address should fail");
    } catch Error(string memory /*reason*/) {
        // Expecting an error
    }

    assertEq(tk.balanceOf(bob), STARTING_BAL);
}

}