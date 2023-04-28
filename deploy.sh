#!/bin/bash
DAT3='0x6748abb929b79db07daf1f4f93c81cde7e298562fbaf80ab6fa8b6b59d15582a'
PROFILE="test2"

echo "dat3:  $DAT3  $PROFILE"
BASE_PATH=`pwd `
DAT3_COIN="$BASE_PATH/dat3-coin"
DAT3_CORE="$BASE_PATH/dat3-core"
DAT3_T_INTERFACE="$BASE_PATH/interface"
DAT3_STAKING="$BASE_PATH/staking"


echo "aptos move compile -->  $DAT3_COIN  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_COIN --bytecode-version 6 `
echo""
sleep 3
echo "aptos move publish --> $DAT3_COIN   "
echo `aptos move publish --profile  $PROFILE  --assume-yes --package-dir  $DAT3_COIN --bytecode-version 6 `
echo""
sleep 3
cd ..
DAT3_POOL="`pwd`/dat3-contract-core/reward-pool"
DAT3_POOL_payment="`pwd`/dat3-contract-core/payment"
DAT3_NFT="`pwd`/dat3-nft/dat3-Invitation-nft"
DAT3_NFT_REWARD="`pwd`/dat3-nft/invitation_reward"
N_PROFILE=$PROFILE"_nft"
echo $N_PROFILE
sleep 3
echo "aptos move compile -->  $DAT3_NFT  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_NFT --bytecode-version 6 `
echo""
sleep 3
echo "aptos move publish --> $DAT3_NFT   "
echo `aptos move publish --profile  $N_PROFILE --assume-yes --package-dir  $DAT3_NFT --bytecode-version 6 `
echo""
sleep 3
echo "aptos move compile -->  $DAT3_NFT_REWARD  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_NFT_REWARD --bytecode-version 6 `
echo""
sleep 3
echo "aptos move publish --> $DAT3_NFT_REWARD   "
echo `aptos move publish --profile  $N_PROFILE --assume-yes --package-dir  $DAT3_NFT_REWARD --bytecode-version 6 `
echo""
sleep 3
echo "aptos move compile -->  $DAT3_POOL  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_POOL --bytecode-version 6 `
echo""
sleep 3
echo "aptos move publish --> $DAT3_POOL   "
echo `aptos move publish --profile  $PROFILE --assume-yes --package-dir  $DAT3_POOL --bytecode-version 6 `
echo""
sleep 3
echo "aptos move compile -->  $DAT3_POOL_payment  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_POOL_payment --bytecode-version 6 `
echo""
sleep 3
echo "aptos move publish --> $DAT3_POOL_payment   "
echo `aptos move publish --profile  $PROFILE --assume-yes --package-dir  $DAT3_POOL_payment --bytecode-version 6 `
echo""
sleep 3
echo "aptos move compile -->  $DAT3_T_INTERFACE  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_T_INTERFACE --bytecode-version 6 `
echo""
sleep 3
echo "aptos move publish --> $DAT3_T_INTERFACE   "
echo `aptos move publish  --profile  $PROFILE --assume-yes --package-dir  $DAT3_T_INTERFACE --bytecode-version 6 `
echo""
echo "aptos move compile -->  $DAT3_STAKING  "
echo `aptos move compile   --save-metadata --package-dir  $DAT3_STAKING  --bytecode-version 6`
echo""
sleep 3
echo "aptos move publish --> $DAT3_STAKING   "
echo `aptos move publish  --profile  $PROFILE --assume-yes --package-dir  $DAT3_STAKING --bytecode-version 6 `
echo""
echo "aptos move compile -->  $DAT3_CORE  "
echo `aptos move compile  --save-metadata --package-dir  $DAT3_CORE  --bytecode-version 6`
echo""
sleep 3
echo "aptos move publish --> $DAT3_CORE   "
echo `aptos move publish  --profile  $PROFILE --assume-yes --package-dir  $DAT3_CORE  --bytecode-version 6`