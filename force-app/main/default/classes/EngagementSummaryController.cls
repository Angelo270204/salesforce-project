public with sharing class EngagementSummaryController {
    
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getEngagementSummary(Id engagementId) {
        Map<String, Object> result = new Map<String, Object>();
        
        Engagement__c eng = [SELECT Name, Related_Opportunity__r.Amount 
                             FROM Engagement__c 
                             WHERE Id = :engagementId LIMIT 1];
        
        result.put('engagementName', eng.Name);
        result.put('opportunityAmount', eng.Related_Opportunity__c != null ? eng.Related_Opportunity__r.Amount : 0);
        
        Integer completedTasks = [SELECT COUNT() FROM Task WHERE WhatId = :engagementId AND Status = 'Completed'];
        result.put('completedTasks', completedTasks);
        
        Integer upcomingEvents = [SELECT COUNT() FROM Event WHERE WhatId = :engagementId AND StartDateTime >= TODAY];
        result.put('upcomingEvents', upcomingEvents);
        
        return result;
    }

    // NUEVO MÉTODO: Creación de la tarea desde el backend
    @AuraEnabled
    public static void createFollowUpTask(Id engagementId, String engagementName) {
        Task newTask = new Task(
            Subject = 'Follow-up on ' + engagementName,
            ActivityDate = Date.today().addDays(1),
            Type = 'Call',
            WhatId = engagementId
        );
        insert newTask;
    }
}