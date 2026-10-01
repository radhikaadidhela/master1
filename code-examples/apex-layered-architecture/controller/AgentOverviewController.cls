// Screen entry point: keep business logic out of this class.
public with sharing class AgentOverviewController {
    @AuraEnabled(cacheable=true)
    public static AgentOverviewDTO getOverview(Id accountId) {
        if (accountId == null || accountId.getSObjectType() != Account.SObjectType) {
            throw new AuraHandledException('Provide a valid Account ID.');
        }
        return new AgentOverviewFacade().getOverview(accountId);
    }
}
