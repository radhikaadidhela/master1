# DevOps, Security, Performance, Troubleshooting

## CI/CD
Simple explanation: automated/controlled movement of Salesforce changes from development toward production.
Feature branch -> commit -> pull request -> code review -> metadata/test validation -> QA/UAT -> production.
Tools in profile/resume: Git/GitHub, Salesforce CLI/SFDX, Azure DevOps, Copado, Jenkins, Change Sets. Dedicated DevOps teams handled deeper pipeline implementation in some projects; don't overstate ownership.

## Security
Layered: authentication -> authorization -> sharing/record access -> CRUD/FLS -> data retrieval -> integration/action authorization -> audit/monitoring.
`with sharing` helps enforce record-level sharing but does not automatically enforce CRUD/FLS.
Named/External Credentials for secrets/auth.

## Large data volume
Selective SOQL, indexes/selectivity, pagination/keyset, async processing, retention/archival strategy, aggregate instead of loading huge recordsets, minimal fields/payloads. Don't copy every transactional record into CRM without a business reason.

## Troubleshooting/RCA
Impact -> Contain -> Reproduce/Trace -> Root Cause -> Fix -> Regression -> Deploy -> Monitor -> document RCA.
LWC slow: browser/network/Apex/SOQL/external layers.
Blank prod component: user/permissions/data, browser console/network, Apex exceptions, CRUD/FLS/sharing, Experience user access, component visibility/config/dependencies.
Integration: correlation IDs, status/body, server logs, middleware logs, downstream logs.
