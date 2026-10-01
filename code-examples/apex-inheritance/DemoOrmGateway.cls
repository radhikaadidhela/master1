public class DemoOrmGateway extends SettlementGatewayBase {
    public override Decimal getSettlement(String agentId) {
        validateAgentId(agentId);
        // Learning fixture only. A real gateway would call MuleSoft/ORMB.
        return 1250.00;
    }
}
