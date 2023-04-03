import { HardhatUserConfig, task } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/CYp2hBlgYv34ni5P6O9AjkeNU0G4KdgJ",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/1rlFeailNxqJyHA736QgIGJTd1zm8iwc",
      accounts: [process.env.PRIVATE_KEY as string],
    },
  },
};

export default config;
