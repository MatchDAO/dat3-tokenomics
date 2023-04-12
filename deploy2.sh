#!/bin/bash
DAT3='0xeaca9a4b2c3e5a305099b8f68d90587e7f965e2e1f4b7505368872644ef95746'
PROFILE="test5"
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
