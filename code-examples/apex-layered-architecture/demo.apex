// Save the seven classes in a sandbox first.
// Reads only. Choose an existing accessible Account without hardcoded IDs.
List<Account> accounts = [SELECT Id FROM Account WITH USER_MODE LIMIT 1];
if (accounts.isEmpty()) {
    System.debug('No accessible Account found.');
} else {
    AgentOverviewDTO result = AgentOverviewController.getOverview(accounts[0].Id);
    System.debug(JSON.serializePretty(result));
}
