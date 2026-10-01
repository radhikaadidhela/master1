// Profile use case: a summary requires an accessible Account.
public with sharing class AgentProfileService {
    public Account getAgent(Id accountId) {
        List<Account> agents = new AgentAccountSelector().selectById(accountId);
        if (agents.isEmpty()) {
            throw new AuraHandledException('Agent account is unavailable.');
        }
        return agents[0];
    }
}
