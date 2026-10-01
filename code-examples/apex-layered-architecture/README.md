# Apex layers explained with an Agent 360 example

This is a learning example, not deployed Western Union code. For simplicity, an agent is represented by a standard Account and its support requests by standard Cases. Your real org may use a different agent data model.

I interpreted "DB or sto" as database access and possibly DTO. Both are explained here: the selector reads the database; the DTO carries the result.

## Start with the user request

An operations user opens an agent summary and wants two things:

1. Agent name.
2. Number of open support cases visible to that user.

The screen asks one controller method for the summary. The facade coordinates a profile service and a case service. Each service uses a selector to read Salesforce data. The response travels back as a DTO.

```text
REQUEST
LWC: getOverview({ accountId: recordId })
           |
           v
AgentOverviewController      Entry point; validates the input type
           |
           v
AgentOverviewFacade          One front door for the whole summary
           |
           +--> AgentProfileService --> AgentAccountSelector --> Account DB
           |
           +--> AgentCaseService ----> AgentCaseSelector ------> Case DB

RESPONSE
Database results --> Services --> Facade builds AgentOverviewDTO
                                   |
                                   v
                               Controller --> LWC displays the summary
```

These are ordinary Apex method calls in the same request/transaction. A folder does not create a separate process, transaction, or network hop.

## What belongs in each layer?

| Layer | Simple meaning | Responsibility in this example |
|---|---|---|
| Controller | Entry point | Accept Account ID from the screen; call facade |
| Facade | Simplified front door over services | Coordinate profile and case summaries |
| Service | Business/use-case logic | Require an accessible agent; define open cases |
| Selector | SOQL/data access | Query Account; count related Cases |
| Database | Stored records | Actual Salesforce Account and Case data |
| DTO | Data carrier | Return accountId, agentName, openCaseCount |

**Facade and DTO are different:** the facade does coordination; the DTO carries values. The DTO is not another execution layer between the service and database.

## Folder layout and reading order

```text
apex-layered-architecture/
|-- README.md
|-- controller/AgentOverviewController.cls       Read 1st
|-- facade/AgentOverviewFacade.cls               Read 2nd
|-- service/AgentProfileService.cls              Read 3rd
|-- service/AgentCaseService.cls
|-- selector/AgentAccountSelector.cls            Read 4th
|-- selector/AgentCaseSelector.cls
|-- dto/AgentOverviewDTO.cls                     Read 5th
`-- demo.apex
```

The subfolders organize the lesson locally. Salesforce identifies these as Apex classes; these folder names are not namespaces.

## 1. Controller: where the screen enters Apex

**Definition:** The controller exposes an operation to the client.

**Why/when:** An LWC needs a server method to obtain its combined summary. Keep the controller small so business behavior can be reused from other entry points.

```apex
@AuraEnabled(cacheable=true)
public static AgentOverviewDTO getOverview(Id accountId) {
    if (accountId == null || accountId.getSObjectType() != Account.SObjectType) {
        throw new AuraHandledException('Provide a valid Account ID.');
    }
    return new AgentOverviewFacade().getOverview(accountId);
}
```

Read it as: "Check that the input is an Account ID, then ask the facade for the overview." Checking the ID type does not authorize access to the record.

`@AuraEnabled` makes the method callable by LWC/Aura when the caller has Apex class access. `static` allows invocation without constructing a controller. `cacheable=true` fits a read-only method and permits client caching; it does not make the result live or continuously fresh.

## 2. Facade: one request hides several service calls

**Definition:** A facade provides a simple front door over multiple services or subsystems.

**Why/when:** The screen should not need to coordinate separate profile and case calls or know all the internal classes.

```apex
Account agent = new AgentProfileService().getAgent(accountId);
AgentOverviewDTO overview = new AgentOverviewDTO();
overview.accountId = agent.Id;
overview.agentName = agent.Name;
overview.openCaseCount = new AgentCaseService().getOpenCaseCount(accountId);
return overview;
```

Read it as: "Get the agent, get the open-case count, package both results." Calls run sequentially. If the profile lookup fails, the case service is not called.

The facade assembles the screen-level result. It delegates the business definition of open cases to the case service.

## 3. Service: decide what the business operation means

**Definition:** A service owns business/use-case behavior and coordinates work needed for that behavior.

**Why/when:** A rule should be reusable beyond one screen. For example, a REST endpoint could reuse the profile service.

Profile service:

```apex
List<Account> agents = new AgentAccountSelector().selectById(accountId);
if (agents.isEmpty()) {
    throw new AuraHandledException('Agent account is unavailable.');
}
return agents[0];
```

Business rule: the overview requires an accessible Account. The message does not distinguish a nonexistent record from a record the user cannot see.

Case service:

```apex
return new AgentCaseSelector().countByClosedState(accountId, false);
```

Business rule: "open" means `IsClosed = false`, rather than a hardcoded status name such as `New`. The selector performs the query for that criterion.

These services are deliberately small to make the boundaries easy to see. This teaching version uses `AuraHandledException` for friendly errors. A larger reusable service layer could throw a business exception and let each controller translate it for its caller.

## 4. Selector: where SOQL lives

**Definition:** A selector encapsulates database reads.

**Why/when:** Centralizing queries makes selected fields and access rules easier to maintain. A service asks for data without embedding the SOQL.

```apex
return [
    SELECT Id, Name
    FROM Account
    WHERE Id = :accountId
    WITH USER_MODE
    LIMIT 1
];
```

The result is a List of Account records. A list can be empty, so the service checks it before accessing index zero.

```apex
return [
    SELECT COUNT()
    FROM Case
    WHERE AccountId = :accountId AND IsClosed = :isClosed
    WITH USER_MODE
];
```

This returns the count directly instead of loading every Case into memory. It counts records visible to the caller, not necessarily every case across the enterprise.

`with sharing` declares record-sharing behavior. Explicit `WITH USER_MODE` enforces user access for these queries, including object and field permissions. If the caller lacks required permissions, the query can fail; the code does not silently elevate access.

## 5. Database: the actual stored records

The database is Salesforce's data store. There is no custom `DatabaseLayer.cls` required here. The selectors query standard Account and Case objects.

```text
Account: Id = illustrative Account ID, Name = "Demo Agent"
Case A: AccountId = same Account, IsClosed = false
Case B: AccountId = same Account, IsClosed = false
Case C: AccountId = same Account, IsClosed = true
```

If all three Cases are visible to the caller, the open-case count is 2. These are illustrative records; the sample does not create them.

## 6. DTO: the response package

**Definition:** DTO means Data Transfer Object. It contains the values passed between layers or returned to a client.

**Why/when:** The screen needs a combined response instead of separate Account and Case results.

```apex
public class AgentOverviewDTO {
    @AuraEnabled public Id accountId { get; set; }
    @AuraEnabled public String agentName { get; set; }
    @AuraEnabled public Integer openCaseCount { get; set; }
}
```

The properties are exposed for the LWC response. There is no SOQL or business logic here. This is a top-level class, rather than an Apex inner class used as the LWC return type.

Conceptually, the returned data looks like:

```text
{
  accountId: <the requested Account ID>,
  agentName: "Demo Agent",
  openCaseCount: 2
}
```

## Runtime walkthrough

1. LWC passes an Account ID to `AgentOverviewController.getOverview`.
2. Controller rejects null or a different object ID, then calls the facade.
3. Facade asks profile service for the agent.
4. Profile service calls Account selector; the database returns an accessible Account or an empty list.
5. Profile service returns the Account, or raises an error if unavailable.
6. Facade asks case service for the open-case count.
7. Case service passes `false` for closed state; Case selector runs the count query.
8. Facade builds the DTO; controller returns it to LWC.

The successful controller path uses two SOQL queries and no DML. A permission error stops the request. No settlement callout happens in this example.

## Where an external settlement system fits

For current settlement data, use a gateway rather than a Salesforce selector:

```text
Controller -> Facade -> SettlementService -> ISettlementGateway
                                                 |
                                            ORMBGateway
                                                 |
                                   Named/External Credential
                                                 |
                                              MuleSoft
                                                 |
                                                ORMB
```

Selector = Salesforce data access. Gateway = external-system abstraction. The interface and abstract-class examples in `../apex-inheritance/` demonstrate that gateway contract with fixed learning values; they do not perform real calls. An external-data facade would also need explicit decisions about freshness, failure handling, and client caching.

## Do I always need all these layers?

No. A simple record read can often use Lightning Data Service. A small Apex feature may only need a controller and service. A facade is useful when it meaningfully hides several services or subsystems; adding a forwarding class everywhere does not automatically improve a design.

This example includes two services so the facade has a concrete coordination role. A Domain layer could own richer record-specific behavior later, but it is unnecessary for these simple read operations.

## Run the example

Save the seven `.cls` files in a Salesforce sandbox, then run `demo.apex` using Execute Anonymous. The script chooses one accessible Account and prints the DTO as JSON. The user needs access to the relevant Account/Case objects and fields. LWC use additionally requires permission to access the controller class.

The script adds one Account query before the two-query controller path. It performs no writes. Its output depends on actual visible sandbox records.

This is a learning folder, not a deployable Salesforce DX package. Classes have not been compiled or executed in an org during authoring. To deploy through DX, copy them into an existing project's classes directory with matching metadata files.

## Spoken answer: about 30 seconds

"The controller is the entry point from the UI. It delegates to a facade, which provides a simple front door over multiple services. Each service handles a business use case, such as finding an agent or defining open cases. A selector contains SOQL and reads the Salesforce database. The facade combines the results into a DTO and returns it to the screen. For an external system, the service uses a gateway instead of a selector."

## Official references

- [Secure Apex classes](https://developer.salesforce.com/docs/platform/lwc/guide/apex-security): sharing, object/field permissions, user-mode queries, and Apex class access.
- [Client-side caching](https://developer.salesforce.com/docs/platform/lwc/guide/apex-result-caching): read-only cacheable methods and refreshing cached results.
