# Salesforce Technical Assessment - README

## 1. What you built, any assumptions, and how to test each item (#3–#8)

**What I built:**
I configured a custom Salesforce app to track "Engagements", establishing relational data models (Master-Detail with Account, Lookup with Opportunity). The implementation includes custom objects, a Lightning Web Component (LWC) powered by an Apex backend, automated record-triggered Flows, and custom analytics.

**Assumptions:**
* **Apex over uiRecordApi:** Because the standard JavaScript `uiRecordApi` has limited support for creating `Task` records, I assumed the best practice was to build a custom Apex Controller (`EngagementSummaryController.cls`) to securely handle the DML operation, exposing it to the LWC via `@AuraEnabled`.
* **Flow Due Date:** I implemented a `CASE(WEEKDAY(...))` formula to correctly calculate `TODAY() + 2 business days` (skipping weekends) for the follow-up task due date.

**How to test each item:**
* **#3 (Activity Logging):** Navigate to the "Consultoría Acme 2026" Engagement record. Check the Activity Timeline to see the manually logged call, email, and event (Kickoff meeting).
* **#4 & #6 (LWC & Apex):** On the same Engagement record, locate the "Engagement Summary" custom component. Click the `Quick Follow-Up Call` button. Verify the success toast and check the timeline for the newly created task.
* **#5 (List Views & Chart):** Navigate to the Engagements tab. Select the `Q Engagements by Account` list view and click the chart icon (top right) to display the Donut chart aggregating the budget.
* **#7 (Flow Automation):** Open the related "Acme Corp - IT Consulting" Opportunity. Change the Stage to `Negotiation/Review` and save. Return to the Engagement record and verify that the high-priority task "Prepare proposal" was automatically generated in the timeline.
* **#8 (Reports):** Navigate to the Reports tab. Open the `Engagement Pipeline` report to view the bar chart displaying the Sum of Amount grouped by Status.

---

## 2. Links/paths to your LWC and Apex classes

The source code can be found in the standard SFDX project structure within this repository:

* **Apex Controller:** `/force-app/main/default/classes/EngagementSummaryController.cls`
* **LWC Bundle:** `/force-app/main/default/lwc/engagementSummary/`
  * HTML: `engagementSummary.html`
  * Controller: `engagementSummary.js`
  * Metadata: `engagementSummary.js-meta.xml`

---

## 3. The report and list view names

* **Report Name:** `Engagement Pipeline` *(Built using a new Custom Report Type: "Engagements with Opportunities")*
* **List View Names:** 
1. `My Open Engagements`
2. `Q Engagements by Account`

---

## 4. Screenshots / Evidence

All requested evidence files are located in `/screenshots`:

1. **Engagement record page + LWC:** 
[`/screenshots/view-lwc.png`](./screenshots/view-lwc.png)

2. **Logging a call / email / event:** 
[`/screenshots/activity-timeline.png`](./screenshots/activity-timeline.png)

3. **The Flow firing:** 
[`/screenshots/flow.png`](./screenshots/flow.png)

4. **The report + chart:** 
[`/screenshots/report-chart.png`](./screenshots/report-chart.png)

5. **List view chart:** 
[`/screenshots/list-view-chart.png`](./screenshots/list-view-chart.png)