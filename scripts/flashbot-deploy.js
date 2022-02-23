const hre = require("hardhat");

// 部署闪电交易机器人合约
async function main() {
    const FlashBot = await hre.ethers.getContractFactory("FlashBot");
    const flashBot = await FlashBot.deploy();
    await flashBot.deployed();
    console.log("FlashBot deployed to:", flashBot.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
