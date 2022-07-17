const Oat = artifacts.require("OAT");
const string= artifacts.require("StringUtils");


module.exports = async function(deployer) {
	//deploy Token
	await deployer.deploy(string);
    await deployer.link(string, Oat);
    await deployer.deploy(Oat);

	// //assign token into variable to get it's address
	// const token = await Token.deployed()
    // deployer.deploy(LibA);
// deployer.link(LibA, B);
// deployer.deploy(B);
	
	// //pass token address for dBank contract(for future minting)
	// await deployer.deploy(dBank, token.address)

	// //assign dBank contract into variable to get it's address
	// const dbank = await dBank.deployed()

	// //change token's owner/minter from deployer to dBank
	// await token.passMinterRole(dbank.address)
};