#!/bin/bash
DAT3='0x5e932115b35aa53c360dbff0edee0f74d3165e89d584319ab2fb7036bdd24cb3'
DAT3_NFT='0x135138fb03c8b52d9c1c933e35560f2ad523f6e5f152cbe760f77bedfe8f616b'
PROFILE="test1"
N_PROFILE=$PROFILE"_nft"
echo "dat3:' $DAT3'"
echo""
echo "dat3_core::init_dat3_coin"
echo `aptos move run --profile $PROFILE   --assume-yes --function-id $DAT3::dat3_core::init_dat3_coin`
sleep 3
echo""
echo "pool::init_pool"
echo `aptos move run --profile $PROFILE   --assume-yes --function-id $DAT3::pool::init_pool`
sleep 3
echo""
echo "reward::init"
echo `aptos move run  --profile $PROFILE   --assume-yes --function-id $DAT3::reward::init`
sleep 3
echo""
echo "payment::init"
echo `aptos move run  --profile $PROFILE   --assume-yes --function-id $DAT3::payment::init`
sleep 3
echo""
echo "invitation_reward::init"
echo `aptos move run  --profile $N_PROFILE  --assume-yes --function-id $DAT3_NFT::invitation_reward::init`
