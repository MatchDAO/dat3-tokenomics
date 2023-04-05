module dat3::tokenomics_interface {
    use dat3::interface;
    public fun to_reward(admin:&signer){
        interface::to_reward(admin);
    }
}