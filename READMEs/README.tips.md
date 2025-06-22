# TLDR

Random useful tips

## How to deploy a contract

1. Update `hardhat.config.ts` with blockchain network configuration
```ts
networks: {
  baseSepolia: {
    url: "https://sepolia.base.org",
    chainId: 84532,
    accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
  }
}
```
2. Install dotenv and import it into the `hardhat.config.ts` file
```ts
import * as dotenv from "dotenv";
dotenv.config();
```
3. Deploy the contract
```sh
npx hardhat ignition deploy ./ignition/modules/Lock.ts --network baseSepolia
```

## How to compile a contract with HardHat

`npx hardhat compile`