module dat3::dat3_core {
    use std::error;
    use std::signer;
    use std::string;

    use aptos_std::math128;
    use aptos_std::math64;
    use aptos_framework::account::{Self, SignerCapability};
    use aptos_framework::coin::{Self, BurnCapability, FreezeCapability, MintCapability};
    use aptos_framework::reconfiguration;
    use aptos_framework::timestamp::{Self, now_seconds};

    use dat3::dat3_coin::DAT3;

    // use dat3::dat3_pool_routel;

    struct HodeCap has key {
        burnCap: BurnCapability<DAT3>,
        freezeCap: FreezeCapability<DAT3>,
        mintCap: MintCapability<DAT3>,
    }

    /// genesis info
    struct GenesisInfo has key, store {
        /// seconds
        genesis_time: u64,
        epoch: u64,
    }

    //Mint Time
    struct MintTime has key, store {
        /// seconds
        time: u64,
        supplyAmount: u64,
        epoch: u64,
    }

    //hode resource account SignerCapability
    struct SignerCapabilityStore has key, store {
        sinCap: SignerCapability,
    }


    /// 100 million
    const MAX_SUPPLY_AMOUNT: u64 = 5256000 ;
    //365
    const SECONDS_OF_YEAR: u128 = 31536000 ;
    const EPOCH_OF_YEAR: u128 = 4380 ;
    //ONE DAY
    //  const SECONDS_OF_DAY: u64 = 86400 ;
    const TOTAL_EMISSION: u128 = 7200;
    //0.7
    const TALK_EMISSION: u128 = 5040;
    //0.15
    const STAKE_EMISSION: u128 = 1080;
    //0.15
    const INVESTER_EMISSION: u128 = 1080;

    const PERMISSION_DENIED: u64 = 1000;
    const SUPPLY_OUT_OF_RANGE: u64 = 1001;

    const EINSUFFICIENT_BALANCE: u64 = 107u64;
    const NO_USER: u64 = 108u64;
    const NO_TO_USER: u64 = 108u64;
    const NOT_FOUND: u64 = 110u64;
    const ALREADY_EXISTS: u64 = 111u64;
    const OUT_OF_RANGE: u64 = 112;
    const INVALID_ARGUMENT: u64 = 113;
    const ASSERT_MINT_ERR: u64 = 114;

    /********************/
    /* ENTRY FUNCTIONS */
    /********************/
    public entry fun init_dat3_coin(owner: &signer)
    {
        assert!(signer::address_of(owner) == @dat3, error::permission_denied(PERMISSION_DENIED));
        //only once
        assert!(!exists<GenesisInfo>(@dat3_admin), error::already_exists(ALREADY_EXISTS));
        let (burnCap, freezeCap, mintCap) =
            coin::initialize<DAT3>(owner,
                string::utf8(b"DAT3_alpha"),
                string::utf8(b"DAT3_alpha"),
                6u8, true);

        let (resourceSigner, sinCap) = account::create_resource_account(owner, b"dat3");
        move_to(&resourceSigner, HodeCap {
            burnCap, freezeCap, mintCap
        });
        move_to(&resourceSigner, SignerCapabilityStore {
            sinCap
        });
        coin::register<DAT3>(owner);
        move_to(&resourceSigner, MintTime { time: 0, supplyAmount: 0, epoch: 0, });
        let time = timestamp::now_seconds();
        let epoch = reconfiguration::current_epoch();
        move_to(&resourceSigner,
            GenesisInfo {
                genesis_time: time,
                epoch,
            }
        );
        //Inform Genesis
        dat3::stake::init(owner, time, epoch);
    }

    public fun mint_to(_owner: &signer) acquires HodeCap, MintTime, GenesisInfo, SignerCapabilityStore
    {
        assert!(assert_mint_time(), error::aborted(ASSERT_MINT_ERR));
        //for test
        // if(!assert_mint_time()){
        //     return
        // };
        let last = borrow_global_mut<MintTime>(@dat3_admin);
        if (last.time == 0 || last.time == 1) {
            assert!(signer::address_of(_owner) == @dat3, error::permission_denied(PERMISSION_DENIED));
        };
        let cap = borrow_global<HodeCap>(@dat3_admin);

        let mint_amount = assert_mint_num();
        assert!(mint_amount > 0, error::aborted(ASSERT_MINT_ERR));

        let mint_coins = coin::mint((mint_amount as u64), &cap.mintCap);
        let last = borrow_global_mut<MintTime>(@dat3_admin);
        last.supplyAmount = (mint_amount as u64) + last.supplyAmount;
        last.time = now_seconds();
        last.epoch = reconfiguration::current_epoch();
        let sinCap = borrow_global<SignerCapabilityStore>(@dat3_admin);
        let sin =account::create_signer_with_capability(&sinCap.sinCap);
        //begin distribute reward
        //reward fund
        dat3::pool::deposit_reward_coin(
            coin::extract(&mut mint_coins, ((mint_amount * TALK_EMISSION / TOTAL_EMISSION) as u64))
        );

        //stake reward fund
        dat3::stake::mint_pool( &sin,
            coin::extract(&mut mint_coins, ((mint_amount * STAKE_EMISSION / TOTAL_EMISSION) as u64))
        );
        //team fund
        coin::deposit(@dat3, mint_coins);

        //distribute reward

        dat3::tokenomics_interface::to_reward( &sin);
    }
    /*********************/
    /* PRIVATE FUNCTIONS */
    /*********************/

    //Make sure it's only once a day
    fun assert_mint_time(): bool acquires MintTime
    {
        let last = borrow_global<MintTime>(@dat3_admin);
        //Maximum Mint
        if (last.supplyAmount >= MAX_SUPPLY_AMOUNT * math64::pow(10, (coin::decimals<DAT3>() as u64))) {
            return false
        };
        if (last.epoch == 0) {
            return true
        } else if (reconfiguration::current_epoch() - last.epoch >= 12) {
            //current_epoch - last.epoch =12
            // 0  2  4  6  8  10 12 14 16 18 20  22   0    2   4  6   8   10  12  14  16  18  20  22  0   2  4  6  8  10 12 14 16 18 20 22 0
            // 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26 27 28 29 30 31 32 33 34 35 36 37 38 39 40
            // 1                                      1                                               1                                    1
            //                                       12                                               12                                   12
            return true
        };
        return false
    }

    //The number of coins that can be mint today
    fun assert_mint_num(): u128 acquires MintTime, GenesisInfo
    {
        let last = borrow_global<MintTime>(@dat3_admin);
        let gen = borrow_global<GenesisInfo>(@dat3_admin);
        //Maximum Mint
        if (last.supplyAmount >= MAX_SUPPLY_AMOUNT * math64::pow(10, (coin::decimals<DAT3>() as u64))) {
            return 0u128
        };
        let now = reconfiguration::current_epoch();
        let year = ((now - gen.epoch) as u128) / EPOCH_OF_YEAR ;
        let m = 1u128;
        let i = 0u128;
        while (i < year) {
            m = m * 2;
            i = i + 1;
        };
        let mint = TOTAL_EMISSION * math128::pow(10, ((coin::decimals<DAT3>()) as u128)) / m  ;
        return mint
    }
    /*********************/
    /* VIEW FUNCTIONS */
    /*********************/
    #[view]
    public fun genesis_info(): (u64, u128, u64, u64) acquires MintTime, GenesisInfo
    {
        let mint_num = assert_mint_num();
        let last = borrow_global<MintTime>(@dat3_admin);
        let gen = borrow_global<GenesisInfo>(@dat3_admin);
        (gen.genesis_time, mint_num, last.epoch, gen.epoch)
    }
}