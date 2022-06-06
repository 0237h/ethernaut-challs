// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/**
 * @title GoldenParachute
 * @dev Can receive ether and self-destruct, giving it to another contract
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract GoldenParachute {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {

    }

    function makeItRain(address payable _to) public {
        require(msg.sender == owner);
        selfdestruct(_to);
    }
}