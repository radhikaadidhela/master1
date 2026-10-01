public class DemoSettlementService {
    private ISettlementGateway gateway;

    public DemoSettlementService(ISettlementGateway gateway) {
        this.gateway = gateway;
    }

    public Decimal getCurrentSettlement(String agentId) {
        return gateway.getSettlement(agentId);
    }
}
