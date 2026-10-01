// One front door coordinates two services for the screen.
public with sharing class AgentOverviewFacade {
    public AgentOverviewDTO getOverview(Id accountId) {
        Account agent = new AgentProfileService().getAgent(accountId);
        AgentOverviewDTO overview = new AgentOverviewDTO();
        overview.accountId = agent.Id;
        overview.agentName = agent.Name;
        overview.openCaseCount = new AgentCaseService().getOpenCaseCount(accountId);
        return overview;
    }
}
