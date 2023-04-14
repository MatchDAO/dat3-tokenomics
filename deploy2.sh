#!/bin/bash
DAT3='0x25ef1bacaafb6a69b099c00091d9f4c52cc0b963236dead831bc2000fb23246e'
PROFILE="dat3_alpha"
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
echo "routel::init"
echo `aptos move run  --profile $PROFILE   --assume-yes --function-id $DAT3::routel::init`
