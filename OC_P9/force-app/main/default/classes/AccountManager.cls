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

public class AccountManager{

// create a ethod that updates account's annual revenue.

    public static void updateAccountARevenue ( Set<Id> accountsId, Map<Id, Decimal> amounts){
        List<Account> accountsToUpdate = [ SELECT id, AnnualRevenue FROM Account WHERE Id IN :accountsId];
        for( Account a : accountsToUpdate)
        if( a.AnnualRevenue != null){
            a.AnnualRevenue += amounts.get(a.Id);
        }
        update(accountsToUpdate);
            }
}