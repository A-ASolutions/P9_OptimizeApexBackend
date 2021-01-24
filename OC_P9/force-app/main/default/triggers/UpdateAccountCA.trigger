/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-24-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   01-24-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
trigger UpdateAccountCA on Order (after update) {
	
    set<Id> setAccountIds = new set<Id>();
    
    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
       
        Account acc = [SELECT Id, AnnualRevenue FROM Account WHERE Id =:newOrder.AccountId ];
        acc.AnnualRevenue = acc.AnnualRevenue + newOrder.TotalAmount;
        update acc;
    }
}