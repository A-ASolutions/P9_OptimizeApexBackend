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
global class UpdateAllAccounts implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator('SELECT Id FROM Account');

   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){
       List<Account> AP01Account = new List <Account>();
       Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
     // AP01Account.UpdateAccounts(setAccountIds);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}