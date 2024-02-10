require("@nomicfoundation/hardhat-toolbox");

require("@nomiclabs/hardhat-etherscan")

const key = "8d5dc68f333ed9ca6b8482e78d21a69a1f50d861b839dbbddee0d3b5e49c8897";
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks:{
    mumbai:{
      url:"https://polygon-mumbai.g.alchemy.com/v2/O4DCybOmylKsCBfBLR5A54dggdgBHj0O",
      accounts:[key],
    }
  },
  etherscan:{
    apiKey:'BI2PR6NZ8TJ2EQT5XRH2B7BKZ4RWCSGSZQ',
  }
};

