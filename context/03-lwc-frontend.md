# LWC / Aura / Visualforce / JavaScript / CSS

## Communication
Parent -> child: `@api` property/method.
Child -> parent: `CustomEvent`.
Unrelated components: Lightning Message Service (LMS).

## Lifecycle / DOM
DOM = browser's in-memory tree representing rendered UI.
Flow:
Component created
  -> constructor()
  -> connectedCallback()
  -> render/template
  -> renderedCallback()
  -> user/data/reactive change
  -> rerender
  -> renderedCallback()
  -> removal
  -> disconnectedCallback()

`constructor`: JS instance initialization; don't assume rendered template exists.
`connectedCallback`: component connected; initialization/setup/subscription registration where appropriate. It is not LMS itself and not reactive data provisioning.
`renderedCallback`: rendered DOM is available; DOM-dependent work. It may run many times, so guard against loops.
`disconnectedCallback`: cleanup/unsubscribe.

## Data access
`@wire`: reactive data provisioning. `$recordId` or another `$property` is reactive and can cause reprovisioning.
Imperative Apex: explicit sequencing/control, user actions, create/update, integrations.
`refreshApex`: refresh wired result after mutation.

## Errors
Imperative Apex: async/await try/catch/finally or Promise `.catch()`.
Wire: `{data,error}`.
Normalize error body; show toast or inline message. Apex expected business errors may use `AuraHandledException`.
`errorCallback(error, stack)` can act as descendant error boundary.

## Performance diagnosis
Do not optimize blindly. Isolate: browser rendering/JS -> network -> Apex -> SOQL -> external API.
Use browser DevTools Network/Performance for duplicate calls, payloads, timing/rendering; Apex debug logs for CPU/execution; query analysis for selectivity; integration logs for downstream latency.
Optimization: lazy loading, pagination, server filtering, selective fields, cache, consolidate calls, avoid heavy getters/repeated rerenders, stable `key`, minimal payloads.

Agent 360 page: load Agent Summary/Open Cases immediately; lazy-load Transactions/Settlement/Equipment/Documents tabs.

## Experience Cloud security
Client-supplied record ID is not authorization. Validate on server using sharing plus CRUD/FLS. UI filtering/visibility is presentation, not authorization.
