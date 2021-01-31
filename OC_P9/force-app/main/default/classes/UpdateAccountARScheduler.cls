/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   01-28-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
global class UpdateAccountARScheduler implements Schedulable {
        
    global void execute(SchedulableContext sc) {
        UpdateAccountsARevenue batch = new UpdateAccountsARevenue(); 
        Id batchId = Database.executeBatch(batch);  
   }

}