# Recent Interview Lessons

## Highest-priority repair order
1. Interfaces / Abstract / Virtual
2. Enterprise Patterns / Facade / DTO
3. @wire vs connectedCallback vs imperative Apex / LMS
4. Answer delivery: Definition -> Why/when -> Example
5. Flow vs Apex decision framework
6. LWC performance diagnosis

## Flow vs Apex
Don't decide only by new vs existing. Evaluate complexity, reuse, transaction control, integrations, volume, maintainability, testing, error handling, ownership.
Good answer: straightforward record automation/orchestration -> Flow; complex reusable logic/integration/sophisticated errors/transaction control -> Apex; combine when useful.

## Facade trap
Facade is NOT primarily a DTO/payload wrapper. It hides complexity and provides a simple front door over multiple services.

## @wire trap
`@wire` and `connectedCallback` are not alternatives. Wire = reactive data; connectedCallback = lifecycle init; imperative Apex = explicit control; LMS = unrelated communication.

## LWC performance
First diagnose, then optimize. Browser rendering/JS -> Network -> Apex -> SOQL -> external API.

## Code review example
If implementation processes growing dataset in one transaction and risks CPU/query rows, explain why Batch can split transactions and improve scalability/failure isolation; don't just say "large data = Batch."

## Live Apex example
Business requirement: create one follow-up Task per Opportunity, relate via WhatId, assign owner from related Account owner. Collect Account IDs -> one SOQL -> map -> build Tasks in loop -> one insert outside loop. Guard null AccountId/map lookup.

## REST mistake to avoid
HTTP response status = `HttpResponse.getStatusCode()`. `Database.SaveResult` is DML result, not HTTP.

## Delivery
Avoid fillers and searching aloud. It is fine to say: "I haven't used that deeply in production, so I don't want to overstate it. My understanding is..." or "Let me use a concrete example."
