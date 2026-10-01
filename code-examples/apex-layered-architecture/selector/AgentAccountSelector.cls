// Database access belongs here. Bind variables avoid string-built SOQL.
public with sharing class AgentAccountSelector {
    public List<Account> selectById(Id accountId) {
        return [
            SELECT Id, Name
            FROM Account
            WHERE Id = :accountId
            WITH USER_MODE
            LIMIT 1
        ];
    }
}
