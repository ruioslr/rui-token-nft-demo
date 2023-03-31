import hre, { ethers } from "hardhat";
import { BigNumber } from "ethers";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const RuiToken = await ethers.getContractFactory("RuiToken");
  const ruiToken = await RuiToken.deploy(
    "Rui",
    "RUI",
    18,
    BigNumber.from("1000000000000000000000000000")
  );

  await ruiToken.deployed();

  console.log(
    `RuiToken deployed to: ${
      ruiToken.address
    }, total supply: ${await ruiToken.totalSupply()}, network: ${
      hre.network.name
    }}}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
