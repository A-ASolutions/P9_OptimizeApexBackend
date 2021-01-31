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
trigger OrderTrigger on Order ( before update, after update){

if (trigger.isAfter){
List<order>  trigerOrder = Trigger.new;

OrderTriggerHandler.updateAccountFromOrder(Trigger.oldMap, Trigger.newMap);
}
else{
for (Order newOrder : Trigger.New){
if (newOrder.TotalAmount != null && newOrder.ShipmentCost__c != null){
newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
}
}
}
}
