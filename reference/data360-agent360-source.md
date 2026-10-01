Yes. Based on the project details we have discussed across your Salesforce work, the **best Data 360 use case for your Western Union story is not just “agent analytics.”** It should be an **Agent 360 / Agent Lifecycle 360** use case that connects the agent's **onboarding → equipment → transactions → customers → service/support → settlement → performance** journey.

That gives you a much stronger interview story because it naturally uses almost every important Data 360 capability.

Your Western Union scope already includes **Global Agent Enrollment, Agent Provisioning, Agent Maintenance, WURS Settlement, Sales Cloud, Service Cloud and Experience Cloud**. Agent Provisioning also included equipment ordering, training requests and non-PC orders.

---

# 1. Start with the business problem

In an interview, start very simply:

> **“At Western Union, agents are a critical part of the money-transfer business. An agent could be onboarded and managed through Salesforce, while transaction and operational activity could exist in other systems such as the agent portal and AWS-based systems. Salesforce also supported areas such as sales, service, settlement, agent maintenance and provisioning.**
>
> **The challenge was that agent information was distributed across multiple systems. Business teams could see pieces of the agent's information, but they didn't have a unified view of the agent, their transaction activity, customers served, equipment, service issues and settlement performance.”**

That is your **problem statement**.

---

# 2. What did we want to build?

The goal was:

> **Create a unified Agent 360 profile in Data 360 so business and operations teams could understand an agent from onboarding through ongoing business activity.**

Think:

```
```

```
                    AGENT 360
                       |
       +---------------+----------------+
       |               |                |
    Profile        Operations        Performance
       |               |                |
  Agent details    Transactions       Volume
  Location         Customers          Revenue
  Status            Equipment         Trends
  Region            Service Cases     Settlement
       |               |                |
       +---------------+----------------+
                       |
                  Data 360
```

This is much stronger than saying:

> "We used Data 360 for analytics."

---

# 3. What information did we bring together?

You can explain four major sources.

### Source 1 — Salesforce

Salesforce contained things such as:

```
```

```
Agent
Agent Account
Agent status
Region
Territory
Onboarding status
Sales information
Service Cases
Equipment orders
Training requests
Settlement-related information
```

Your existing Western Union work included Global Agent Enrollment, Agent Maintenance, Agent Provisioning and WURS Settlement across Salesforce clouds.

---

### Source 2 — Agent Portal

The agent portal could provide operational activity such as:

```
```

```
Agent login
Money-transfer activity
Transaction activity
Customer transactions
Transaction status
Activity timestamps
```

You don't need to claim that every one of these was actually implemented in Data 360 unless it was. Present them as the **data required for the use case** if this was a POC/design.

---

### Source 3 — AWS / external transaction systems

AWS/external systems could provide:

```
```

```
Transaction ID
Agent ID
Transaction amount
Transaction date
Transaction type
Customer type
Country/region
Transaction status
```

Your project technology stack includes AWS, REST/SOAP APIs, MuleSoft and other enterprise integration technologies.

---

### Source 4 — Equipment / provisioning

This is where your story becomes interesting.

When a **new agent is onboarded**, Salesforce can initiate:

```
```

```
Agent Enrollment
      ↓
Agent Provisioning
      ↓
Equipment Order
      ↓
Training Request
      ↓
Agent Activated
```

Your documented Agent Provisioning work specifically included **equipment ordering, training requests and non-PC orders**.

So Data 360 can eventually give the business a broader picture:

```
```

```
Agent
 |
 +-- Profile
 |
 +-- Onboarding
 |
 +-- Equipment
 |
 +-- Training
 |
 +-- Transactions
 |
 +-- Customers
 |
 +-- Service
 |
 +-- Settlement
 |
 +-- Performance
```

---

# 4. Data 360 architecture

Now you can explain the technical architecture.

```
```

```
                 SOURCE SYSTEMS
                       |
       +---------------+----------------+
       |               |                |
   Salesforce      Agent Portal        AWS
       |               |                |
       +---------------+----------------+
                       |
                APIs / MuleSoft /
                Data Integration
                       |
                       v
                DATA 360
                       |
                 Data Streams
                       |
                       v
                     DLOs
                       |
                  Data Mapping
                       |
                       v
                     DMOs
                       |
                       v
              Identity Resolution
                       |
                       v
              Unified Agent Profile
                       |
          +------------+-------------+
          |            |             |
          v            v             v
   Calculated      Segments       Activation
    Insights
          |
          v
      Analytics
          |
          v
       Agentforce
```

Your Data 360 experience already includes ingestion, DLO/DMO mapping, identity resolution, unified profiles, segmentation and activation concepts, including integration with CRM/Agentforce.

---

# 5. Data Streams

Explain this simply.

> **“We first identify the different source systems and bring their data into Data 360 through Data Streams.”**

For example:

```
```

```
Salesforce Agent Data
        ↓
Salesforce Data Stream

AWS Transaction Data
        ↓
External Data Stream

Agent Portal Activity
        ↓
External Data Stream
```

Each source has a different structure.

For example, Salesforce:

```
```

```
{
  "agentId": "A10045",
  "agentName": "ABC Money Services",
  "region": "Texas",
  "status": "Active"
}
```

AWS transaction system:

```
```

```
{
  "agentId": "A10045",
  "transactionId": "TX90001",
  "amount": 450,
  "transactionDate": "2026-08-20",
  "customerType": "Retail"
}
```

The important thing is:

**different systems use different data structures.**

---

# 6. DLO — Data Lake Object

The raw source information lands in Data 360's data lake layer.

You can say:

> **“The source data initially lands in DLOs, where we preserve the incoming source information before harmonizing it into the Data 360 data model.”**

For example:

```
```

```
Salesforce Agent DLO

Agent_ID
Agent_Name
Region
Status
Source_System
```

And:

```
```

```
Transaction DLO

Transaction_ID
Agent_ID
Amount
Transaction_Date
Customer_Type
Status
```

---

# 7. DMO — Data Model Object

Now we harmonize the data.

Suppose Salesforce calls it:

```
```

```
Agent_ID
```

AWS calls it:

```
```

```
AgentNumber
```

Agent portal calls it:

```
```

```
AgentCode
```

We map these into the common Data 360 model:

```
```

```
                 Data 360
                    |
             Individual/Agent
                    |
                Agent ID
                    |
        +-----------+-----------+
        |                       |
   Salesforce              AWS Portal
   Agent_ID                AgentNumber
        |                       |
        +----------+------------+
                   |
              Unified Agent
```

Your interview statement:

> **“We mapped the source-specific fields into a common Data 360 model so that information from different systems could be analyzed consistently.”**

---

# 8. Identity Resolution — VERY important

This is one of the strongest parts of your story.

Imagine:

### Salesforce

```
```

```
Agent ID: A10045
Name: ABC Money Services
```

### AWS

```
```

```
AgentNumber: A10045
Name: ABC Money Service
```

### Portal

```
```

```
AgentCode: A10045
BusinessName: ABC Money Services LLC
```

Data 360 needs to understand:

> **These records represent the same agent.**

Identity Resolution applies matching rules and creates the unified identity.

```
```

```
Salesforce Agent
      |
      |
AWS Agent ---------> Identity Resolution
      |                     |
Portal Agent               |
                            v
                     Unified Agent
                        A10045
```

You can say:

> **“Identity resolution was important because the same agent could appear differently across systems. We used matching rules and identifiers to determine that those records belonged to the same real-world agent.”**

Your documented Data 360 work specifically includes identity resolution and unified customer profiles.

---

# 9. The final Agent 360 profile

Now the business sees something like:

```
```

```
AGENT 360
------------------------------------------------
Agent: ABC Money Services
Agent ID: A10045
Region: Texas
Status: Active
Onboarding Date: Jan 15, 2026

TRANSACTIONS
------------------------------------------------
Daily Volume:              185
Monthly Transactions:    5,420
Transaction Value:     $1.8M

CUSTOMER MIX
------------------------------------------------
Retail Customers:          72%
Business Customers:        28%

OPERATIONS
------------------------------------------------
Equipment Orders:             3
Training Status:        Completed
Service Cases:                2

SETTLEMENT
------------------------------------------------
Settlement Status:      Up to Date

PERFORMANCE
------------------------------------------------
30-Day Trend:             +12%
90-Day Trend:              +8%
```

**This is the business value of Data 360.**

Instead of jumping between five systems, the business has one unified view.

---

# 10. Calculated Insights

This is where you show that you're not just storing data.

You calculate metrics.

For example:

### Daily transaction volume

```
```

```
COUNT(Transaction)
GROUP BY Agent
GROUP BY Transaction Date
```

Result:

```
```

```
Agent A10045
----------------
Monday       152
Tuesday      185
Wednesday    174
Thursday     201
Friday       220
```

---

### Transaction value

```
```

```
SUM(Transaction Amount)
GROUP BY Agent
```

---

### Average transaction value

```
```

```
SUM(Transaction Amount)
/
COUNT(Transaction)
```

---

### Customer mix

```
```

```
Retail Customers
vs
Business Customers
```

---

### Growth

```
```

```
Current 30-day volume
        vs
Previous 30-day volume
```

This lets the business identify:

```
```

```
High-performing agents
Growing agents
Declining agents
Low-volume agents
High-value agents
Unusual activity
```

---

# 11. Segmentation

Now take the calculated metrics and create useful segments.

For example:

### High-volume agents

```
```

```
Daily transactions > 200
```

### Growing agents

```
```

```
30-day growth > 15%
```

### Low-volume agents

```
```

```
Daily transactions < 25
```

### New agents

```
```

```
Agent age < 90 days
```

### Agents needing attention

```
```

```
Volume declining
+
Service cases increasing
```

Then:

```
```

```
Unified Agent Profile
        ↓
Calculated Insights
        ↓
Segmentation
```

---

# 12. Equipment becomes part of the lifecycle

This is a particularly nice addition to your story.

Suppose a new agent joins.

### Day 1

```
```

```
Agent Enrollment
       ↓
Agent created in Salesforce
       ↓
Provisioning initiated
       ↓
Equipment ordered
       ↓
Training requested
```

Then the agent starts operating:

```
```

```
Equipment
   +
Training
   +
Transactions
   +
Customers
   +
Service
   +
Settlement
```

Data 360 can connect these dimensions to understand:

> **Does onboarding readiness affect agent productivity?**

For example:

```
```

```
Agents with equipment delivered
              ↓
Average daily volume = 180

Agents waiting for equipment
              ↓
Average daily volume = 35
```

Now Data 360 isn't merely reporting transactions.

It's helping the business understand **agent lifecycle and operational performance**.

---

# 13. Service Cloud connection

Suppose an agent has:

```
```

```
Volume ↓ 30%
Service Cases ↑
Equipment issue = Open
```

The business can identify:

> This agent's performance decline may be related to an unresolved operational issue.

Instead of treating the agent's transaction performance and service history as unrelated data, the unified profile gives context.

That's a very good **Service + Data 360** story.

---

# 14. Settlement connection

Your Western Union project also includes WURS Settlement and settlement-related processing.

So your Agent 360 could show:

```
```

```
Agent
 |
 +-- Transaction Activity
 |
 +-- Settlement Activity
 |
 +-- Service
 |
 +-- Equipment
 |
 +-- Onboarding
```

The business can answer:

> "Is this agent generating transactions but experiencing settlement issues?"

That's much more valuable than simply saying:

> "This agent made 500 transactions."

---

# 15. Activation

After segmentation, Data 360 can activate the information.

For example:

```
```

```
Segment:
High-volume agents
        ↓
Activation
        ↓
Sales / Service / downstream systems
```

Or:

```
```

```
Segment:
Agents with declining activity
        ↓
Activation
        ↓
Business follow-up
```

Or:

```
```

```
New Agent
+
Equipment Delivered
+
Training Complete
        ↓
Ready for Business
```

That information can be used downstream.

---

# 16. Agentforce opportunity

This is where your story can become very current.

You can say:

> **“Once the unified Agent 360 profile is available, Agentforce can use the grounded Data 360 information to provide contextual assistance.”**

For example, an operations user asks:

> **“Show me the status of agent A10045.”**

Agentforce could retrieve:

```
```

```
Agent Status: Active
Daily Volume: 185
30-Day Growth: +12%
Equipment: Complete
Training: Complete
Open Cases: 2
Settlement: Current
```

Then ask:

> **“Why did their volume decline last week?”**

The agent could use grounded data to identify relevant signals, such as:

```
```

```
Volume ↓
Equipment issue
Service Case
Transaction trend
```

Your existing Data 360 work is positioned around making unified data available for CRM/Agentforce grounding and personalized experiences.

---

# 17. What YOU should say you personally did

This is extremely important in interviews.

Don't say:

> "I built the whole Data 360 platform."

Instead:

> **“My responsibility was primarily on the Salesforce/Data 360 technical side. I worked on understanding the source data, defining the ingestion requirements, mapping source fields to the Data 360 model, configuring and validating data ingestion, supporting identity resolution, and validating the unified agent profile. I also worked on calculated insights and segmentation requirements and collaborated with integration and business teams on activation and downstream use cases.”**

That sounds much more credible.

---

# 18. Your complete 90-second interview answer

If the interviewer asks:

### **"Tell me about your Data 360 project."**

Use this:

> **“One of the Data 360 use cases I worked on was an Agent 360 solution for Western Union. Western Union has agents across different regions who perform money-transfer activities. Salesforce supported areas such as agent enrollment, provisioning, sales, service and settlement, while additional transaction and operational data existed in external systems.**
>
> **The challenge was that agent information was distributed across multiple systems, so business teams didn't have a unified view of an agent's onboarding status, equipment, transactions, customers, service activity and performance.**
>
> **We used Data 360 to bring the data together through Data Streams, land it in DLOs, map it into the Data Model, and use Identity Resolution to create a unified agent profile. We then used Calculated Insights to calculate metrics such as daily transaction volume, transaction value, customer mix and trends.**
>
> **We could then segment agents based on business criteria such as high volume, new agents or declining activity, and make that information available for analytics, activation and AI use cases. The key value was giving the business a unified Agent 360 view instead of requiring them to look across multiple systems.”**

---

# 19. If they ask for the architecture

Give them this:

```
```

```
                    WESTERN UNION
                         |
       +-----------------+------------------+
       |                 |                  |
   Salesforce       Agent Portal           AWS
       |                 |                  |
       +-----------------+------------------+
                         |
                  APIs / MuleSoft
                         |
                         v
                    DATA 360
                         |
                  Data Streams
                         |
                         v
                       DLOs
                         |
                  Data Mapping
                         |
                         v
                       DMOs
                         |
                         v
               Identity Resolution
                         |
                         v
                UNIFIED AGENT 360
                         |
          +--------------+--------------+
          |              |              |
          v              v              v
   Calculated        Segmentation    Activation
     Insights
          |
          v
      Analytics
          |
          v
     Agentforce / AI
```

---

## 20. The strongest business story

The entire story can be summarized as:

**New Agent**

```
```

```
Enrollment
   ↓
Provisioning
   ↓
Equipment Order
   ↓
Training
   ↓
Activation
   ↓
Transactions
   ↓
Customers
   ↓
Service
   ↓
Settlement
   ↓
Performance
```

**Data 360 connects that lifecycle into one Agent 360 profile.**

That is the use case I would recommend you use in interviews because it connects your **actual Western Union Salesforce experience**—Global Agent Enrollment, Agent Provisioning, equipment ordering, Service Cloud, Sales Cloud and settlement—with your **Data 360 knowledge**, without making the story unnecessarily complicated.

If an interviewer starts drilling down, the natural next questions are **“Show me exactly how you configured the Data Stream,” “What DLO/DMO did you use?”, “How did Identity Resolution work?”, “What was the matching rule?”, “How did you calculate daily volume?”, and “How did you expose this to Agentforce?”** Those are the areas we should prepare next.