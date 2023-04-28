# DAT3 Tokenomics  Contract

This smart contract is part of the MatchDAO ecosystem and is designed to support various functions such as token issuance, transfer, and rewards for both holders and community contributions.

## ABOUT DAT3

DAT3 provides influencers or professionals with a tool to monetize their influence. 
This need has been long-standing but not well met. 
We hope to solve this problem by building the underlying blockchain communication protocol. DAT3 is our first attempt.

## Features
- The DAT3 token has an initial issue size of 0 and a total volume of less than 5,256,000.
- 7,200 DAT3 will be released every 12 epochs.
- Relative liquidity is controlled through a "governance right = stake volume * time" scheme.
- Deflationary mechanism for tokens is guaranteed through a perpetual buyback of platform fee revenue and an NFT auction system.  
- 15% of the tokens will be locked as stake rewards each time tokens are released
- 15% of tokens will be locked up as team rewards every time tokens are released
- 70% of tokens will be locked up as community rewards every time tokens are released 

## Requirements

- aptos-cli
- 
## Deployment

1. Clone this repository: `git clone https://github.com/matchdao/dat3-tokenomics.git`
2. Clone DAT3-invitation_NFT repository: `git clone https://github.com/MatchDAO/dat3-nft`
3. Clone DAT3-payment repository: `https://github.com/MatchDAO/dat3-contract-core`
4. Install dependencies: `git clone https://github.com/aptos-labs/aptos-core/tree/mainnet`
5. Navigate to the project directory: `cd dat3-tokenomics`
6. Run aptos-cli init DAT3 : `aptos init --profile dat3`
7. Run aptos-cli init DAT3_NFT : `aptos init --profile dat3_nft`
8. For all addresses whose name is "dat3" in the Move.toml file, fill in the address generated in step 6
9. For all addresses whose name is "dat3_owner" in the Move.toml file, fill in the address generated in step 7
10. Modify the "PROFILE" and dat3 addresses of deploy.sh and deploy2.sh
11. run `./deply.sh`
12. run `./deply2.sh`

## Contribution

We welcome contributions to this project. To contribute:

1. Fork this repository
2. Create a new branch: `git checkout -b my-new-feature`
3. Make changes and commit them: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.