#!/bin/bash
DAT3='0x4f48ef49472364f88267f14b49efe1a951ecb90819025c86955014a38c839075'
PROFILE="test4"
echo "dat3:' $DAT3'"
echo""
echo "dat3_core::init_dat3_coin"
#echo `aptos move run --profile $PROFILE   --assume-yes --function-id $DAT3::dat3_core::init_dat3_coin`
sleep 3
echo""
echo "pool::init_pool"
#echo `aptos move run --profile $PROFILE   --assume-yes --function-id $DAT3::pool::init_pool`
sleep 3
echo""
echo "routel::init"
echo `aptos move run  --profile $PROFILE   --assume-yes --function-id $DAT3::routel::init`
