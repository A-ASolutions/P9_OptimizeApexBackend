/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   01-31-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
@isTest

public class OrderTrigger_Test{
    @TestSetup
    static void testSetup(){

        Product2 pd1 = new Product2(Name= 'XYX long green shirt', Family = 'Shirt');
        insert pd1;

         //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;
        
        Account accWithNoARevenue = new Account(Name = 'noAR');
        Account  accwithARevenue = new account (Name = 'withAR', AnnualRevenue =3000);
        insert new Account[]{accWithNoARevenue, accwithARevenue};
    }

}