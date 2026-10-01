// Business definition: an open case has IsClosed = false.
public with sharing class AgentCaseService {
    public Integer getOpenCaseCount(Id accountId) {
        return new AgentCaseSelector().countByClosedState(accountId, false);
    }
}
