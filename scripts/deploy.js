const hre = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners(); //get the account to deploy the contract

  console.log("Deploying contracts with the account:", deployer.address); 
  
  // We get the contract to deploy
  const UniversityDegree = await hre.ethers.getContractFactory("UniversityDegree");
  const universitydegree = await UniversityDegree.deploy();

  await universitydegree.deployed();

  console.log("UniversityDegree deployed to:", universitydegree.address);

  await hre.run("verify:verify", {
    address: universitydegree.address,
    constructorArguments: [],
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
