# Radhika Salesforce Codex Workspace

This workspace is the persistent context for Salesforce development, architecture, interview preparation, resume tailoring, and job-application support.

## Accuracy rule
Never invent production experience. Distinguish clearly among: (1) production hands-on experience, (2) proof-of-concept/design/learning experience, and (3) interview-preparation knowledge. When uncertain, use conservative wording such as "worked through", "designed", "supported", "POC", or "focusing on".

## Candidate profile
Radhika Mandala is a Senior Salesforce Developer / Technical Lead with about 10 years of IT/Salesforce experience. Core strengths: Apex, LWC, Flow, SOQL/SOSL, REST/SOAP, MuleSoft, Platform Events, Salesforce security, enterprise integrations, troubleshooting, production support, solution design, code reviews, releases, and technical leadership.

Current Western Union work (Apr 2024-present): WURS/Retail Settlement migration, Agent Maintenance, Agent Provisioning, Global Agent Enrollment, Everest Commission Model, Price Item/Price Component, ITIN/prepaid automation, equipment/training/non-PC provisioning forms, ORMB integrations, batch/scheduled processing, Email-to-Case RCA, deployments/release/security. Data 360 and Agentforce are newer areas and include POCs/design/use cases; do not imply years of deep production ownership unless source material supports it.

Previous: Quant Systems (Sep 2022-Apr 2024): Sales/Service/Experience Cloud, Apex/LWC/Flow, SAP/MuleSoft/REST/SOAP/Platform Events, CPQ/Revenue Cloud concepts, NICE CXone/Omni-Channel, Einstein chatbot, Marketing Cloud/Journey Builder/Email Studio/Content Builder/Data Extensions/Marketing Cloud Connect. Elevance Health (Nov 2018-Aug 2021): Service Cloud, Apex/LWC/Visualforce, SOQL, automation, Service Console, migrations/Data Loader, approvals/security/Copado. Prudential (Jan 2017-Sep 2018): Salesforce admin/development including Apex Trigger Framework, Lightning Components, Visualforce, Service Cloud. See resumes for complete earlier history.

Certifications include Agentforce Specialist, Platform Developer II, Platform Developer I, Administrator, Platform App Builder, JavaScript Developer I, Data 360 Consultant, AI Associate, Salesforce Associate, and Trailhead Five-Star Ranger/Agentblazer Legend as represented in current resume.

## Interview answer style
Teach and answer using: Definition -> Why/when -> Concrete example. Spoken answers should normally be 20-40 seconds unless deeper detail is requested. Prefer simple, precise language over buzzwords. For learning, include ASCII flow diagrams and runtime examples.

## Critical concepts to preserve
- Interface = contract + loose coupling.
- Abstract class = contract + shared implementation.
- Virtual class = default implementation that can be overridden.
- Facade = simplified front door over multiple services/subsystems; NOT a DTO.
- DTO = data carrier.
- Controller = entry point.
- Service = business/use-case orchestration.
- Selector = SOQL/data access.
- Domain = business behavior/rules.
- Gateway = external-system abstraction.
- Flow = declarative automation/orchestration.
- Apex = complex deterministic programmatic control.
- @wire = reactive data provisioning.
- imperative Apex = explicit call/control.
- connectedCallback = lifecycle initialization when component connects.
- renderedCallback = post-render DOM work; may run repeatedly.
- disconnectedCallback = cleanup when component leaves.
- @api = parent->child/public API.
- CustomEvent = child->parent.
- LMS = unrelated component communication.
- Browser DevTools = client/network diagnosis; debug logs = Apex/server diagnosis.
- Batch Apex = large processing split across transactions.
- Idempotency = safe duplicate/retry protection.

## LWC lifecycle mental model
Component instantiated -> constructor -> connectedCallback -> render -> renderedCallback -> reactive state/data changes -> rerender -> renderedCallback -> component removed -> disconnectedCallback.
Do not say connectedCallback means rendered DOM is fully available. @wire is not a lifecycle hook.

## Western Union architecture examples
Agent 360/Settlement Assistant: Operations User -> Agentforce -> Topic/Instructions -> grounding (Data 360 structured + approved Knowledge/RAG) -> actions (Flow/Apex/API) -> MuleSoft -> ORMB/external systems -> human approval for sensitive actions.
Current settlement should normally come from authoritative system through action/integration; Data 360 is suited to unified/historical context.

Data 360 conceptual flow: Sources -> Data Streams -> DLO -> mapping -> DMO -> Identity Resolution -> Unified Profile -> Calculated Insights -> Segmentation/Activation -> Agentforce/analytics.
Do not use an LLM to solve enterprise identity; resolve identity/governance before grounding.

Integration example: LWC -> Controller -> Service -> ISettlementGateway -> ORMBGateway -> Named/External Credential -> MuleSoft -> ORMB. For writes/retries use correlation IDs, logging, appropriate retry/backoff, idempotency, and reconciliation/status checks when outcome is unknown.

## Security
Authentication -> authorization -> record/data access -> retrieval filtering -> grounding -> action authorization -> human approval. Semantic relevance is not authorization. Prompt instructions are not a security boundary. LWC visibility/filtering is not authorization. Enforce sharing/CRUD/FLS/server-side access.

## Resume/job rules
Prioritize remote US roles first, then McKinney/Plano/Frisco/Richardson/Dallas/DFW hybrid, then broader US hybrid only for strong matches. C2C and W2 are both acceptable. Prefer postings from last 24 hours. Target Senior Salesforce Developer, Lead Developer/Technical Lead, Senior Salesforce Engineer, Agentforce/Salesforce AI, Data 360/Data Cloud, and appropriate hands-on architect roles. Avoid pure Admin/junior roles unless explicitly requested.

Do not claim deep FSC production experience. Safe FSC positioning: core Salesforce production experience in financial-services-related enterprise applications plus strong understanding/preparation of FSC data model and banking use cases.

Do not include SSN, passport, DOB, driver's-license number, EAD/identity-document numbers, or full home address in normal recruiter/application materials unless explicitly and legitimately required.

## Files
- `resume/` contains current/alternate resumes.
- `context/` contains consolidated Salesforce knowledge.
- `interview-prep/` contains question-specific preparation.
- `reference/data360-agent360-source.md` preserves prior detailed Agent 360/Data 360 material.
