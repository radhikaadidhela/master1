# Apex, Architecture, Integrations

## Apex fundamentals
Prepare deeply: governor limits; bulkification; Sets/Maps/Lists; one SOQL/DML outside loops; trigger contexts; handler frameworks; recursion control; transaction boundaries; exception handling; CRUD/FLS/sharing; test classes; mocking callouts; async Apex; LDV/selectivity.

Bulk mental model: Collect -> Query -> Map -> Process -> DML.
Never dereference `map.get(key)` without considering null.

Async:
- Future: legacy/simple async callouts, limited compared with Queueable.
- Queueable: preferred for complex async jobs/chaining/stateful payloads.
- Batch: large datasets split into transactions; scalable/failure isolation.
- Scheduled: time-based orchestration.

## Enterprise layers/patterns
LWC/Flow -> Controller -> Service -> Domain/Selector/Gateway -> DB/external systems.
Use patterns to solve coupling/testability/maintainability, not as decoration.

Facade: simple entry point over multiple services, e.g. Agent360Facade coordinating AgentService, CaseService, SettlementService, EquipmentService.
DTO: transfer structure only.

Interface example:
`ISettlementGateway` defines `getSettlement(agentId)`; ORMBGateway implements it. Service depends on contract, enabling loose coupling/testing/replacement.
Abstract base gateway can provide common auth headers, correlation IDs, logging/error handling.

## Integrations
Patterns: synchronous request-reply, async fire-and-forget, Platform Event pub/sub, scheduled/batch, API-led integration.
MuleSoft API-led concept: Experience API tailored to channel/consumer; Process API orchestrates business process; System API encapsulates systems of record.

Authentication: Named Credential + External Credential/OAuth for Salesforce outbound integrations; avoid hardcoded secrets. Server-to-server OAuth commonly uses client credentials/JWT-style patterns depending provider/config. Authorization-code is user-delegated and involves user authorization/callback.

Outbound REST handling: `HttpResponse.getStatusCode()` and `getBody()`; `Database.SaveResult` is DML, not HTTP status.
HTTP categories: 400 bad request, 401 auth, 403 authorization, 429 throttling, 5xx server/transient.

Resilience: timeouts, retry/backoff only where safe, correlation ID, structured logging, graceful errors, idempotency for retryable writes, reconciliation/status query when write outcome is unknown.

Platform Events vs CDC: PE is explicit business/event message; CDC publishes record-change events. Both use Salesforce event infrastructure/event bus concepts but serve different semantics.
Platform-event-triggered Flows exist and can subscribe/process Platform Events declaratively where appropriate.
