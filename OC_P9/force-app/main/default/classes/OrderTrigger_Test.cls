/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-06-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   01-31-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
@isTest
public class OrderTrigger_Test{
    @TestSetup
    static void testSetup(){

        // Insert a product  

        Product2 pd1 = new Product2(Name= 'XYX long green shirt', Family = 'Shirt');
        insert pd1;

         //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 150,
            IsActive = true
        );
        Insert pbe;
        
        // create  2 accounts
        Account accWithNoARevenue = new Account(Name = 'noAR');
        Account  accwithARevenue = new account (Name = 'withAR', AnnualRevenue =3000);
        insert new Account[]{accWithNoARevenue, accwithARevenue};

        // create 2 contracts

        Contract contr1 = new Contract (AccountId = accwithARevenue.Id, ContractTerm = 24, StartDate = date.today(), Status = 'Draft');

        Contract contr2 = new Contract ( AccountId = accWithNoARevenue.Id, ContractTerm = 12, StartDate = date.today(), Status = 'Draft');

        insert new Contract[]{contr1, contr2};

        // Activate contracts

        contr1.Status = 'Activated';
        contr2.Status = 'Activated';

        update contr1;
        update contr2;

    }

// Test update annual revenue when there is no previous value

@isTest
Static void updateAnnualRevenueWithZeroValue(){
    account acc = [SELECT Id, AnnualRevenue FROM Account WHERE Name = 'noAR'];
    PricebookEntry pbe = [SELECT Id, Pricebook2Id FROM PricebookEntry WHERE UnitPrice = 150];
   acc.AnnualRevenue = 0;
   update acc;

    Test.startTest();
    // insert an order

      Order o1 = new Order(AccountId = acc.Id, Status ='Draft', Pricebook2Id = pbe.Pricebook2Id, EffectiveDate = date.today());
        insert o1;

        // insert an item
         OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=1, UnitPrice = 150);
         insert oi1;

         // update the order status to launch the trigger
         o1.Status = 'Ordered';
         update o1;
         Test.stopTest();

         Account updatedAccount = [SELECT Id, AnnualRevenue FROM Account WHERE Name = 'noAR'];
         System.assertEquals(150, updatedAccount.AnnualRevenue, 'The Annaul Revenue should be 150');


    }

// Test update annual revenue when there is previous value

@isTest
Static void updateAnnualRevenueWithPreviousValue(){
    account acc = [SELECT Id, AnnualRevenue FROM Account WHERE Name = 'withAR'];
    PricebookEntry pbe = [SELECT Id, Pricebook2Id FROM PricebookEntry WHERE UnitPrice = 150];
    System.assertEquals (3000, acc.AnnualRevenue, 'The Annual Revenue initial value is 3000');

    Test.startTest();
    // insert an order

      Order o1 = new Order(AccountId = acc.Id, Status ='Draft', Pricebook2Id = pbe.Pricebook2Id, EffectiveDate = date.today());
        insert o1;

        // insert an item
         OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=1, UnitPrice = 150);
         insert oi1;

         // update the order status to launch the trigger
         o1.Status = 'Ordered';
         update o1;
         Test.stopTest();

         Account updatedAccount = [SELECT Id, AnnualRevenue FROM Account WHERE Name = 'withAR'];
         System.assertEquals(3150, updatedAccount.AnnualRevenue, 'The Annaul Revenue should be 3150');


    }

    // Test update annual revenue when there is previous value and order status is draft

@isTest
Static void updateAnnualRevenueWithPreviousValueWhenOrderStausIsDraft(){
    account acc = [SELECT Id, AnnualRevenue FROM Account WHERE Name = 'withAR'];
    PricebookEntry pbe = [SELECT Id, Pricebook2Id FROM PricebookEntry WHERE UnitPrice = 150];
    

    Test.startTest();
    // insert an order

      Order o1 = new Order(AccountId = acc.Id, Status = 'Draft', Pricebook2Id = pbe.Pricebook2Id, EffectiveDate = date.today());
        insert o1;

        // insert an item
         OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity =1, UnitPrice = 150);
         insert oi1;

         // update the order status to launch the trigger
        //o1.Status = 'Activated';
        // update o1;
         Test.stopTest();

         Account updatedAccount = [SELECT Id, AnnualRevenue FROM Account WHERE Name = 'withAR'];
         System.assertEquals(3000, updatedAccount.AnnualRevenue, 'The Annaul Revenue should be 3000');

    }

    //test to calculate the NetAmount.

@isTest
Static void caluclateNetAmountBasedOnTotalAmountAndShipmentCost(){
    account acc = [SELECT Id, AnnualRevenue FROM Account WHERE Name = 'noAR'];
    PricebookEntry pbe = [SELECT Id, Pricebook2Id FROM PricebookEntry WHERE UnitPrice = 150];
     acc.AnnualRevenue = 0;
   update acc;

    Test.startTest();
    // insert an order

      Order o1 = new Order(AccountId = acc.Id, Status = 'Draft', ShipmentCost__c = 20, Pricebook2Id = pbe.Pricebook2Id, EffectiveDate = date.today());
        insert o1;

        // insert an item
         OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=1, UnitPrice = 150);
         insert oi1;

         // update the order status to launch the trigger
         o1.Status = 'Ordered';
         update o1;
         Test.stopTest();

         Account updatedAccount = [SELECT Id, AnnualRevenue FROM Account WHERE Name = 'noAR'];
         Order  updatedOrder  = [ SELECT Id, NetAmount__c FROM Order WHERE AccountId = :updatedAccount.Id]; 
         System.assertEquals(130, updatedOrder.NetAmount__c, 'The Annaul Revenue should be 130');

    }

// Test update more than one order

@isTest
Static void updateMoreThanOneOrderThenUpdateAccountAR(){
    account acc = [SELECT Id, AnnualRevenue FROM Account WHERE Name = 'noAR'];
    PricebookEntry pbe = [SELECT Id, Pricebook2Id FROM PricebookEntry WHERE UnitPrice = 150];
     acc.AnnualRevenue = 0;
   update acc;

    Test.startTest();
    // insert an order

      Order o1 = new Order(AccountId = acc.Id, Status = 'Draft', Pricebook2Id = pbe.Pricebook2Id, EffectiveDate = date.today());
      Order o2 = new Order(AccountId = acc.Id, Status = 'Draft', Pricebook2Id = pbe.Pricebook2Id, EffectiveDate = date.today());
      Order[] orderList= new Order[]{o1, o2};
        insert orderList;

        // insert an item
         OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=1, UnitPrice = 150);
         OrderItem oi2 = new OrderItem (OrderId = o2.Id, PricebookEntryId = pbe.Id, Quantity=1, UnitPrice = 150);
         insert new OrderItem[]{oi1, oi2};

         // update the order status to launch the trigger
         o1.Status = 'Ordered';
         o2.Status = 'Ordered';
         update orderList;
         Test.stopTest();

         Account updatedAccount = [SELECT Id, AnnualRevenue FROM Account WHERE Name = 'noAR'];
         System.assertEquals(300, updatedAccount.AnnualRevenue, 'The Annaul Revenue should be 300');


    }

}