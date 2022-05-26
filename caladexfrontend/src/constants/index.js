import { InjectedConnector } from "@web3-react/injected-connector";

export const injected = new InjectedConnector({ supportedChainIds: [1, 3, 4, 5, 42, 1337, 31337] });

export const CALADEX_ADDR = "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC" ; //ropsten
export const CUR_CHAIN_ID = 3 ; //ropsten
// export const CUR_CHAINID = 1 ; //mainnet
// export const CALADEX_ADDR = "0x9e93F9444702F9E3b30df939a98D25B9c0D8AfF2"; // mainnet


// export const DAI_ADDR = "0x6B175474E89094C44Da98b954EedeAC495271d0F"; //mainnet
export const DAI_ADDR = "0xad6d458402f60fd3bd25163575031acdce07538d";

export const BLOCK_CONFIRMATION_THRESHOLD = 1;
