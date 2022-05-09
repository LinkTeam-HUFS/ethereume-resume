require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider');

module.exports = {

  networks: {
    development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 7545,            // Standard Ethereum port (default: none)
      network_id: "5777",       // Any network (default: none)
    },
    //ropsten testnet
    ropsten: {
      provider: function() {
        return new HDWalletProvider(
          process.env.MNEMONIC,
          'https://ropsten.infura.io/v3/ed034d60ff3b4a48aae1a579f60e7960'
        )
      },
      gas: 5000000,
      gasPrice: 100000000000,
      network_id: 3
    },
    kovan: {
      provider: function() {
        return new HDWalletProvider(
          process.env.MNEMONIC,
          'https://kovan.infura.io/v3/ed034d60ff3b4a48aae1a579f60e7960'
        )
      },
      gas: 5000000,
      gasPrice: 25000000000,
      network_id: 42
    },
  },
  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },
  compilers: {
    solc: {
       version: "0.8.13",    // Fetch exact version from solc-bin (default: truffle's version)
        optimizer: {
          enabled: true,
          runs: 200
        },
    }
  }
}
