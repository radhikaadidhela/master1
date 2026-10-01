// Data carrier only: no queries, callouts, or business orchestration.
public class AgentOverviewDTO {
    @AuraEnabled public Id accountId { get; set; }
    @AuraEnabled public String agentName { get; set; }
    @AuraEnabled public Integer openCaseCount { get; set; }
}
