#!/bin/bash
DAT3='0x6748abb929b79db07daf1f4f93c81cde7e298562fbaf80ab6fa8b6b59d15582a'
DAT3_NFT='0x6b6a7337ce684ee778cc130a38c62a63ca08240ff7e675d273ecc5f94a94e2a6'
PROFILE="test2"
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
