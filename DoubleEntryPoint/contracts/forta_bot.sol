// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface IDetectionBot {
    function handleTransaction(address, bytes calldata) external;
}

interface IForta {
    function setDetectionBot(address) external;
    function notify(address, bytes calldata) external;
    function raiseAlert(address) external;
}

/**
 * @title FortaBot
 * @dev Just raise an alert when receiving 'msgData' to prevent sweeping DET tokens
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract FortaBot is IDetectionBot {
    address fortaContract = address(0x2c2d0D172139e007EcEb70c35CC8299dc381833F);

    function setFortaContract(address _new) public {
        fortaContract = _new;
    }

    function handleTransaction(address _user, bytes calldata _msgData) public override {
        IForta(fortaContract).raiseAlert(_user);
    }
}