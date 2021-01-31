/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   01-24-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
global class UpdateAccountsARevenue implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
   
       return Database.getQueryLocator([SELECT Id, AnnualRevenue FROM Account WHERE Id IN (SELECT AccountId FROM Order)]);

   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){      
       list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order];
       
		for(Account myAccount :scope){
			myAccount.AnnualRevenue = 0;
           for(Order order : listOrders){
               if( order.AccountId == myAccount.Id){
                   myAccount.AnnualRevenue += order.TotalAmount;
               }                   
           }
       }
       
       update scope;
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}