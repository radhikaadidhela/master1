# Agentforce, Data 360, AI/RAG

## Agentforce
Agentforce provides trusted AI agents that understand requests, reason over grounded context, and invoke approved actions via Flow/Apex/APIs.
Architecture: User -> Agentforce -> Topic/Instructions -> reasoning + grounding -> Actions -> response/business action.
Topic = job/category. Instructions = behavior/boundaries. Actions = bounded approved capabilities.
Flow = deterministic orchestration. Apex = complex deterministic logic. Agentforce = reasoning/conversational orchestration.

## Grounding / RAG
Grounding supplies trusted enterprise context. RAG: retrieve relevant enterprise content -> augment context/prompt -> generate grounded response.
Unstructured flow: document -> parsing/chunks -> embeddings -> Search Index -> Retriever -> relevant chunks -> prompt/LLM.
Search Index = what is searchable. Retriever = how relevant content is selected.
Data Library = approved enterprise knowledge source; don't simplistically call it a vector database.
RAG reduces hallucination but does not eliminate it.

Structured grounding: CRM/Data 360 records, unified profile, calculated insights. Unstructured grounding: Knowledge, policies, SOPs, PDFs.

## Data 360
Sources -> Data Streams -> DLO -> Data Mapping -> DMO -> Identity Resolution -> Unified Profile -> Calculated Insights -> Segmentation/Activation -> analytics/Agentforce.
Matching asks whether records represent same entity; reconciliation determines precedence/value selection.
Calculated Insights = reusable derived metrics.

## Western Union Agent 360 / Settlement Assistant story
Problem: agent data spread across Salesforce enrollment/provisioning/service/settlement plus transaction/operational/external systems.
Goal: unified Agent 360 from onboarding -> equipment -> transactions/customers -> service -> settlement -> performance.

Illustrative identity IDs: Salesforce A10045, transaction system 10045, ORMB 0010045. Resolve identity in Data 360, not with LLM reasoning.
Illustrative calculated insights: 30-day transaction count/value, average transaction, growth, settlement variance, open cases.

Agentforce runtime:
Operations User -> Agentforce -> Settlement Support Topic -> structured Agent 360 context + approved Settlement SOP/Knowledge -> actions such as Get Agent Details / Get Current Settlement / Get Recent Transactions / Get Existing Cases / Create Settlement Case / Escalate -> Flow/Apex -> Named Credential -> MuleSoft -> ORMB.
Current authoritative settlement should be queried from ORMB/external system when freshness matters.
Sensitive financial adjustments require human approval and deterministic execution.

Security: authorization before grounding; least privilege/data minimization; retrieval filtering; action authorization; human approval. Never let prompt instructions replace access control.

Testing: intent/topic, grounding/retrieval, response accuracy, actions/parameters, authorization/negative cases, prompt injection, hallucination, escalation, API failures, latency/refusal.
