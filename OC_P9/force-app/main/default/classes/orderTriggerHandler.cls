/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-26-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   01-25-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class orderTriggerHandler {

    public static void updateAccountFromOrder ( Map<Id, order> orderOldMap, Map<Id,order> orderNewMap){
        Map<Id, Decimal> accountIdWithAmountToAdd = new Map <Id, Decimal>();
        Map<Id,Decimal> amounts  New Map<Id, Decimal>();
        Set <Id> accountsIds = new Set<Id>();
                AccountManager am = new AccountManager();

        for (Order currentOrder : orderNewMap.values()){
            if(orderOldMap.get(currentOrder.Id).Status != currentOrder.Status && currentOrder.Status == 'Ordered'){
                accountIdWithAmountToAdd.put(currentOrder.AccountId, currentOrder.TotalAmount);
                accountsIds.add(currentOrder.AccountId);


            }
            am.updateAccountARevenue(accountsIds, accountIdWithAmountToAdd);
        }





    }

}
