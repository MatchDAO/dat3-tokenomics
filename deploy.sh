#!/bin/bash
DAT3='0xeaca9a4b2c3e5a305099b8f68d90587e7f965e2e1f4b7505368872644ef95746'
PROFILE="test5"
echo "dat3:' $DAT3'"
BASE_PATH=`pwd `
DAT3_COIN="$BASE_PATH/dat3-coin"
DAT3_CORE="$BASE_PATH/dat3-core"
DAT3_T_INTERFACE="$BASE_PATH/interface"
DAT3_STAKING="$BASE_PATH/staking"


echo "aptos move compile -->  $DAT3_COIN  "
#echo `aptos move compile --save-metadata --package-dir  $DAT3_COIN --bytecode-version 6 `
echo""
sleep 3
echo "aptos move publish --> $DAT3_COIN   "
#echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_COIN  `
echo""
sleep 3
cd ..
DAT3_POOL="`pwd`/dat3-contract-core"
DAT3_NFT="`pwd`/dat3-nft"
echo "aptos move compile -->  $DAT3_POOL  "
#echo `aptos move compile --save-metadata --package-dir  $DAT3_POOL --bytecode-version 6 `
#echo""
#sleep 3
#echo "aptos move publish --> $DAT3_POOL   "
#echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_POOL --bytecode-version 6 `
#echo""
cd $BASE
#echo "aptos move compile -->  $DAT3_T_INTERFACE  "
#echo `aptos move compile --save-metadata --package-dir  $DAT3_T_INTERFACE --bytecode-version 6 `
#echo""
#sleep 3
#echo "aptos move publish --> $DAT3_T_INTERFACE   "
#echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_T_INTERFACE --bytecode-version 6 `
echo""
echo "aptos move compile -->  $DAT3_STAKING  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_STAKING  --bytecode-version 6`
echo""
sleep 3
echo "aptos move publish --> $DAT3_STAKING   "
echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_STAKING --bytecode-version 6 `
#echo""
#echo "aptos move compile -->  $DAT3_CORE  "
#echo `aptos move compile --save-metadata --package-dir  $DAT3_CORE  --bytecode-version 6`
#echo""
#sleep 3
#echo "aptos move publish --> $DAT3_CORE   "
#echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_CORE  --bytecode-version 6`
#echo""
#echo "aptos move compile -->  $DAT3_NFT  "
#echo `aptos move compile --save-metadata --package-dir  $DAT3_NFT  --bytecode-version 6`
#echo""
#sleep 3
#echo "aptos move publish --> $DAT3_NFT   "
#echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_NFT --bytecode-version 6 `
echo""