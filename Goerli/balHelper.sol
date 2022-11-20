

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface Test {
function getPoolTokens(bytes32 poolId)
        external
        view
        returns (
            IERC20[] memory tokens,
            uint256[] memory balances,
            uint256 lastChangeBlock
        );
}
contract balHelper {
    address public AddyOfBalancerThing = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;
    bytes32 public poolid1 = 0xcfca23ca9ca720b6e98e3eb9b6aa0ffc4a5c08b90002000000000000000002c3;
    bytes32 public poolid2 = 0x5a6a8cffb4347ff7fc484bf5f0f8a2e234d342550001000000000000000002c4;
	constructor() public {
        
    }
    function pool1Stats () public view returns (uint256 balances1, uint256 balances2){
            
             ( IERC20[] memory ztokens,
            uint256[] memory zbalances,
            uint256 zlastChangeBlock ) =  Test(AddyOfBalancerThing).getPoolTokens(poolid1);

            return (zbalances[0], zbalances[1]);
        }

    function poolTWOStats () public view returns (uint256 balances1, uint256 balances2, uint256 balance3){
            
             ( IERC20[] memory ztokens,
            uint256[] memory zbalances,
            uint256 zlastChangeBlock ) =  Test(AddyOfBalancerThing).getPoolTokens(poolid2);

            return (zbalances[0], zbalances[1], zbalances[2]);
        }

}
