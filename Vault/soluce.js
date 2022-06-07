/* 
	Can't hide nothing on the blockchain ! 

	Since the password is set at the creation of the contract, one can see in the transaction that creates it the new state of the blockchain containing the "secret" password.
	For reference, here is my transaction for my level instance : https://rinkeby.etherscan.io/tx/0x0fdafe3c06294ba1015d4633c3090b0259db220339d1f9d4379386226a2f6032#statechange
*/ 
await contract.unlock(web3.utils.padRight(web3.utils.asciiToHex("A very strong secret password :)"), 64))