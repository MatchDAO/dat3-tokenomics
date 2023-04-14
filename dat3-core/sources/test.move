#[test_only]
module dat3::test {
    use aptos_framework::account;
    use aptos_std::debug;
    use std::signer;
    use dat3::dat3_core::init_dat3_coin;
    use aptos_framework::aptos_account::create_account;
    use aptos_framework::timestamp;
    use aptos_framework::genesis;

    #[test(dat3 = @dat3,fw= @aptos_framework)]
    fun init_dat3_coin1(dat3: &signer,fw:&signer)
    {
        genesis::setup();
        timestamp::set_time_has_started_for_testing(fw);
        timestamp::update_global_time_for_test(1679899905000000);
        create_account(@dat3);
        init_dat3_coin(dat3);
    }

    #[test(dat3 = @dat3)]
    fun test_resource_account(dat3: &signer)
    {
        let (_, _sig1) = account::create_resource_account(dat3, b"dat3_v1");
        let (_, _sig2) = account::create_resource_account(dat3, b"dat3_pool_v1");
        let (_, _sig3) = account::create_resource_account(dat3, b"dat3_routel_v1");
        let (_, _sig4) = account::create_resource_account(dat3, b"dat3_stake_v1");
        let (_, _sig5) = account::create_resource_account(dat3, b"dat3_nft_v1");
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
}