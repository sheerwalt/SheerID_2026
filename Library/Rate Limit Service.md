---
domain: General
type: Concept
created: 2026-01-06
location:
tags:
  - library
aliases:
  - RLS
---

# Rate Limit Service

## Content

### Origin
During a leadership standup we collectively had the idea that we could use the [[WAF]] to help mitigate back verification during [[verification flood events]]. We put together a series of calls to go over this to see how much viability there is here.

### Stage 1 - WAF Ideation
We have the idea to create a Rate Limit Service. The idea was originally to utilize the [[SheerID WAF]] to build up rules to block some bad actors at the border. The WAF is fast and cheap!

We quickly discovered that the WAF can be updated via APIs, but doing so is complex and the rules will get clobbered by any [[Cloud Formation]] event. On top of that, the counting we saw in the WAF rules for http bodies did not carry over to the blocking rules, which meant the whole effort couldn't happen using this mechanism.

### Stage 2 - Rate Limit Interceptor
By the end of the call we decided that it would be clever to implement the RLI as a service between the WAF and the rest of the SheerID application. This means that we could still add rapid blocking before we get to SheerID! It would be like a configurable WAF that _we_ control! How cool! It could have it's own data stores and everything! It was an idea to cool to be true. In addition, the [[Flag Driven Router|FDR]]

### State 3 - Rate Limit Service
By the first half of the second meeting about this we figured that we didn't get much benefit of having it be an interceptor. In fact, we would lose a bunch on information and have to rework a lot of stuff we get in the API layer for free. The new idea was to move this to a new service that the API layer calls. Note: It doesn't have to be a service, it can also live in the application.

This new RLS would let us have all the reporting and logging we have come to expect. It would also allow for custom rate limits and everything! Note: If its in the application or if it's a stand alone service, it can still have it's own data sources. The next thing we realized is that we were essentially re-inventing the [[Bean-Counter Service]], but way upstream.

So, the final idea we had was to use the bean counter to inform the RLS of fraud shapes it's seeing and to hopefully stop them before the rest of the application gets involved. We need this because the bean counter service is slow to update and is designed for look-back fraud detection. Being able to propagate it's findings forward in the process could have benefits.

### Impacts on VRE
There is the opportunity to move some logic and functionality out of the [[VRE]] and into RLS. In particular:
- blocked email domains
- Ip address blocks
- asn and  isp provider blocks

The rest of the work that VRE does should stay with VRE.
### Where we are at now
There is no strong evidence that we need this service now. Instead we are going to punt for a few weeks to see if the bean counter has found any shapes. We will also be paying attention to any rate limit needs that we may have apart from this. 

### Future Considerations
- This still may help with the [[FinLocker]] issue where they are grumpy about the volume of calls we are making into their service. But I'm a bit doubtful. 
- There is rumor that we will begin to forgive verifications to customers labelled as fraud. If this is the case, we will want to avoid as much expense as possible before querying resource-costing services like our Authoritative or Fraud sources

## Links

[Auto-notes from the first call](https://www.google.com/url?q=https://docs.google.com/document/d/1clKDWYvXO8rE9gNXTH9tTRFX-mkIhAL8102VrI1XNuY/edit?tab%3Dt.axiy1lm1iu9d&sa=D&source=calendar&ust=1768176878231614&usg=AOvVaw1Z8xrG08xda8JfZb2imHrR)  
[Doc started by Aaron to capture our thoughts.](https://www.google.com/url?q=https://docs.google.com/document/d/13wVIf7MbKvdhVid60SzJLzL3lwAIOYlLPfM_PsfdLls/edit?tab%3Dt.0%23heading%3Dh.nyws0qg8n26i&sa=D&source=calendar&ust=1768176878231614&usg=AOvVaw1RowStPr-PhnvPUr6qhVLP)
[Miro Board of diagrams](https://miro.com/app/board/uXjVGUU-nGc=/)

## Contributors
[[David Ellis]], [[David Coles]], [[Aaron Martins]], [[Oskar Stephens]], [[Danya Ariel-Boggs]]
