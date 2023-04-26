#[test_only]
module dat3::test {
    use aptos_framework::account;
    use aptos_std::debug;
    use std::signer;
    use dat3::dat3_core::{init_dat3_coin, mint_to};
    use aptos_framework::aptos_account::create_account;
    use aptos_framework::timestamp;
    use aptos_framework::genesis;
    use dat3::reward;
    use dat3::pool;
    use dat3::stake;
    use aptos_framework::coin;
    use dat3::dat3_coin::DAT3;
    use std::string::utf8;

    #[test(dat3 = @dat3,fw= @aptos_framework)]
    fun init_dat3_coin1(dat3: &signer,fw:&signer)
    {
        genesis::setup();
        timestamp::set_time_has_started_for_testing(fw);
        timestamp::update_global_time_for_test(1679899905000000);
        create_account(@dat3);
        init_dat3_coin(dat3);
        pool::init_pool(dat3);
        reward::init(dat3);
        reward::sys_user_init(dat3,1,2,@dat3);
       let (_v1, _v2, _v3, _v4, _v5, _v6, _v7, _v8, _v9, _v10, _v11, _v12, _v13, )= reward::assets(@dat3);
    }

    #[test(dat3 = @dat3)]
    fun test_resource_account(dat3: &signer)
    {

        let (_, _sig1) = account::create_resource_account(dat3, b"dat3_pool_v1");
        let (_, _sig2) = account::create_resource_account(dat3, b"dat3_reward_v1");
        let (_, _sig3) = account::create_resource_account(dat3, b"dat3_stake_v1");
        let (_, _sig4) = account::create_resource_account(dat3, b"dat3_v1");
        let (_, _sig5) = account::create_resource_account(dat3, b"dat3_payment_v1");
        let _sig1 = account::create_signer_with_capability(&_sig1);
        let _sig2 = account::create_signer_with_capability(&_sig2);
        let _sig3 = account::create_signer_with_capability(&_sig3);
        let _sig4 = account::create_signer_with_capability(&_sig4);
        let _sig5 = account::create_signer_with_capability(&_sig5);
        debug::print(&signer::address_of(dat3));
        debug::print(&signer::address_of(&_sig1));
        debug::print(&signer::address_of(&_sig2));
        debug::print(&signer::address_of(&_sig3));
        debug::print(&signer::address_of(&_sig4));
        debug::print(&signer::address_of(&_sig5));
    }

    #[test(dat3 = @dat3,dd=@dat3_reward,fw= @aptos_framework,)]
    fun stake_test(dat3: &signer,dd:&signer,fw:&signer)
    {
        genesis::setup();
        timestamp::set_time_has_started_for_testing(fw);
        timestamp::update_global_time_for_test(1679899905000000);
        create_account(@dat3);
        create_account(@dat3_reward);

        init_dat3_coin(dat3);
        pool::init_pool(dat3);
        reward::init(dat3);
        mint_to(dat3);
        let (_v1,_v2,_v3,_v4,_v5,)=stake::pool_info();
        debug::print(&_v1);
        debug::print(&_v2);
        debug::print(&_v3);
        debug::print(&_v4);
        debug::print(&_v5);

        coin::register<DAT3>(fw);
        coin::register<DAT3>(dd);
        coin::transfer<DAT3>(dat3,@aptos_framework,50000000);
        coin::transfer<DAT3>(dat3,@dat3_reward,50000000);
        stake::deposit(dat3,40000000,1);
        stake::deposit(dd,50000000,0);
        stake::deposit(fw,10000000,1);
        debug::print(&utf8(b"-------------------------"));
        let (_v1,_v2,_v3,_v4,_v5,_v6,_v7,)=stake::your(@dat3);
        debug::print(&_v1);
        debug::print(&_v2);
        debug::print(&_v3);
        debug::print(&_v4);
        debug::print(&_v5);
        debug::print(&_v6);
        debug::print(&_v7);
        debug::print(&utf8(b"-------------------------"));

        let (_v1,_v2,_v3,_v4,_v5,_v6,_v7,_v8,_v9,_v10,_v11,_v12,)
            = stake::your_staking_more(@dat3_reward,0,0);
        debug::print(&_v1);
        debug::print(&_v2);
        debug::print(&_v3);
        debug::print(&_v4);
        debug::print(&_v5);
        debug::print(&_v6);
        debug::print(&_v7);
        debug::print(&_v8);
        debug::print(&_v9);
        debug::print(&_v10);
        debug::print(&_v11);
        debug::print(&_v12);
        debug::print(&utf8(b"-------------------------"));
        let (_v1,_v2,_v3,_v4,_v5,_v6,_v7,_v8,_v9,_v10,_v11,_v12,)
            = stake::your_staking_more(@dat3,0,0);
        debug::print(&_v1);
        debug::print(&_v2);
        debug::print(&_v3);
        debug::print(&_v4);
        debug::print(&_v5);
        debug::print(&_v6);
        debug::print(&_v7);
        debug::print(&_v8);
        debug::print(&_v9);
        debug::print(&_v10);
        debug::print(&_v11);
        debug::print(&_v12);

      }
}