public virtual class SettlementFeePolicy {
    // Usable default behavior; subclasses may replace this method.
    public virtual Decimal calculateFee(Decimal amount) {
        return amount * 0.02;
    }

    // A virtual class does not automatically make every method virtual.
    public String getDescription() {
        return 'Learning example: settlement fee policy';
    }
}
