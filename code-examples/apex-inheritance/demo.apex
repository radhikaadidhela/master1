// Execute Anonymous after saving the seven .cls files in a Salesforce sandbox.
// All values are learning fixtures; there are no callouts or database writes.
ISettlementGateway ormGateway = new DemoOrmGateway();
DemoSettlementService ormService = new DemoSettlementService(ormGateway);
System.debug('ORMB demo settlement: ' + ormService.getCurrentSettlement('A10045'));

DemoSettlementService fixedService = new DemoSettlementService(new DemoFixedGateway());
System.debug('Fixed demo settlement: ' + fixedService.getCurrentSettlement('A10045'));

SettlementFeePolicy defaultPolicy = new SettlementFeePolicy();
SettlementFeePolicy preferredPolicy = new PreferredAgentFeePolicy();
System.debug('Default fee: ' + defaultPolicy.calculateFee(1000));
System.debug('Preferred fee: ' + preferredPolicy.calculateFee(1000));

try {
    ormService.getCurrentSettlement('');
} catch (IllegalArgumentException ex) {
    System.debug('Validation: ' + ex.getMessage());
}
