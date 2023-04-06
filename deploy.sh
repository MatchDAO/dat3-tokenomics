#!/bin/bash
DAT3='0x4f48ef49472364f88267f14b49efe1a951ecb90819025c86955014a38c839075'
PROFILE="test4"
echo "dat3:' $DAT3'"
BASE_PATH=`pwd `
DAT3_COIN="$BASE_PATH/dat3-coin"
DAT3_CORE="$BASE_PATH/dat3-core"
DAT3_T_INTERFACE="$BASE_PATH/interface"
DAT3_STAKING="$BASE_PATH/staking"

echo " dat3_pool_routel::init"
echo `aptos move run   --assume-yes --function-id $DAT3::dat3_pool_routel::init`
echo""
sleep 3
echo "aptos move publish --> $DAT3_COIN   "
echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_COIN  `
cd ..
DAT3_POOL="`pwd`/dat3-contract-core"
echo "aptos move compile -->  $DAT3_POOL  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_POOL  `
echo""
sleep 3
echo "aptos move publish --> $DAT3_POOL   "
echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_POOL  `
echo""
cd $BASE
echo "aptos move compile -->  $DAT3_T_INTERFACE  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_T_INTERFACE  `
echo""
sleep 3
echo "aptos move publish --> $DAT3_T_INTERFACE   "
echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_T_INTERFACE  `
echo""
echo "aptos move compile -->  $DAT3_STAKING  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_STAKING  `
echo""
sleep 3
echo "aptos move publish --> $DAT3_STAKING   "
echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_STAKING  `
echo""
echo "aptos move compile -->  $DAT3_CORE  "
echo `aptos move compile --save-metadata --package-dir  $DAT3_CORE  `
echo""
sleep 3
echo "aptos move publish --> $DAT3_CORE   "
echo `aptos move publish --profile $PROFILE --assume-yes --package-dir  $DAT3_CORE  `
echo""