public class PreferredAgentFeePolicy extends SettlementFeePolicy {
    public override Decimal calculateFee(Decimal amount) {
        return amount * 0.01;
    }
}
