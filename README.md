## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

For more information, visit the [Foundry Book](https://book.getfoundry.sh/).

## Usage

### Build

To build the project, run:

```shell
$ forge build
```

### Test

To run tests, use:

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

To generate gas snapshots, run:

```shell
$ forge snapshot
```

### Anvil

To start a local Ethereum node, use:

```shell
$ anvil
```

### Deploy

To deploy the contract, run the following command with your RPC URL and private key:

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

To use Cast, run:

```shell
$ cast <subcommand>
```

### Help

For help with any command, use:

```shell
$ forge --help
$ anvil --help
$ cast --help
```
