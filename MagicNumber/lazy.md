### Here is my lazy solution to this challenge :

- Look for the contract that deployed the level instance
- Look at other contracts created by this contract (instances given to other players)
- Find one that have transactions to `setSolver()`
- Look at contract code and see if it looks right (less than 10 opcodes, pushes the 42 value and return). Something like this :
```
    0000    60  PUSH1 0x2a
    0002    60  PUSH1 0x80
    0004    52  MSTORE
    0005    60  PUSH1 0x20
    0007    60  PUSH1 0x80
    0009    F3  *RETURN
```
(source from [ethervm.io](https://ethervm.io/decompile/rinkeby/0xcF44404Bd833cB548f9283B8f52616e6c33179D5))
- Call `setSolver()` with the contract address and hope the person who deployed it did solve the level !