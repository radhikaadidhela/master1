public abstract class SettlementGatewayBase implements ISettlementGateway {
    // Shared implementation: every gateway can reuse this validation.
    protected void validateAgentId(String agentId) {
        if (String.isBlank(agentId)) {
            throw new IllegalArgumentException('Agent ID is required.');
        }
    }

    // Required behavior: each concrete child must supply its own body.
    public abstract Decimal getSettlement(String agentId);
}
