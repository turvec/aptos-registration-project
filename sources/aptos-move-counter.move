module 0x3dd9db96e267a3b6e81bd2726ca665b0c237f0ba1c333a2a9c3c9af1ab36594::counter {
    use std::signer;

    /// Error codes
    const ENO_COUNTER: u64 = 1;

    /// Struct to represent the registration counter
    struct Counter has key {
        value: u64
    }

    /// Initialize a new counter for the account
    public entry fun initialize(account: &signer) {
        let counter = Counter { value: 0 };
        move_to(account, counter);
    }

    /// Increment the counter
    public entry fun increment(account: &signer) acquires Counter {
        let addr = signer::address_of(account);
        assert!(exists<Counter>(addr), ENO_COUNTER);
        let counter = borrow_global_mut<Counter>(addr);
        counter.value = counter.value + 1;
    }

    /// Get the current value of the counter
    #[view]
    public fun get_count(addr: address): u64 acquires Counter {
        assert!(exists<Counter>(addr), ENO_COUNTER);
        borrow_global<Counter>(addr).value
    }
}
