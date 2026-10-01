# Compact Answer Bank

## Self introduction
I'm a Senior Salesforce Developer and Technical Lead with around 10 years of IT and Salesforce experience. My core strengths are Apex, LWC, Flow, integrations, security and enterprise Salesforce development. At Western Union I've worked on Agent Maintenance, Agent Provisioning, Global Enrollment and settlement-related solutions, including integrations with enterprise systems. I also participate in solution design, code reviews, deployments and production troubleshooting. More recently, I've been expanding into Data 360 and Agentforce.

## Why good fit
I bring around 10 years of Salesforce/IT experience with strong hands-on expertise in Apex, LWC, Flows, integrations and enterprise Salesforce development. I've worked with REST/SOAP APIs, MuleSoft, security, troubleshooting and production support, and I've taken technical-lead responsibilities such as solution design, code reviews and mentoring. More recently I've expanded into Agentforce and Data 360.

## REST integration recent project
In my recent Western Union project, I worked with REST APIs to integrate Salesforce with external systems through MuleSoft. Salesforce consumed APIs for agent and transaction/settlement-related processes using Apex callouts, with Named Credentials and OAuth-based authentication. I also worked on error handling, response mapping, logging and asynchronous processing where appropriate.

## CI/CD
CI/CD is an automated and controlled way of moving Salesforce changes from development toward production. A developer works on a feature branch, commits changes, raises a pull request, the team reviews it, the pipeline validates metadata/tests, and the change is promoted through QA/UAT/Prod. The goal is repeatable, traceable and safer deployments.

## @wire vs connectedCallback
I think of them as solving different concerns. `@wire` is for reactive data provisioning, while `connectedCallback()` is a lifecycle hook I use for initialization when the component is connected. If data depends on a reactive parameter like `recordId`, I use `@wire`. If I need one-time initialization/lifecycle setup, I use `connectedCallback`. If I need explicit control such as a button-triggered server call, I use imperative Apex.
