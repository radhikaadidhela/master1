public with sharing class AgentCaseSelector {
    public Integer countByClosedState(Id accountId, Boolean isClosed) {
        return [
            SELECT COUNT()
            FROM Case
            WHERE AccountId = :accountId AND IsClosed = :isClosed
            WITH USER_MODE
        ];
    }
}
