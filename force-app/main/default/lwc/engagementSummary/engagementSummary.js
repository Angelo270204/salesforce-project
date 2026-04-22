import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getEngagementSummary from '@salesforce/apex/EngagementSummaryController.getEngagementSummary';
import createFollowUpTask from '@salesforce/apex/EngagementSummaryController.createFollowUpTask';

export default class EngagementSummary extends LightningElement {
    @api recordId;
    summaryData;
    error;

    @wire(getEngagementSummary, { engagementId: '$recordId' })
    wiredSummary({ error, data }) {
        if (data) {
            this.summaryData = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.summaryData = undefined;
        }
    }

    // Llama al método imperativo de Apex
    handleQuickCall() {
        createFollowUpTask({
            engagementId: this.recordId,
            engagementName: this.summaryData.engagementName
        })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Follow-up task created successfully.',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating task',
                        message: error.body ? error.body.message : error.message,
                        variant: 'error',
                    }),
                );
            });
    }
}