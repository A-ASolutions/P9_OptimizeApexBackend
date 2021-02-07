/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-06-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   02-03-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
@isTest
public class updateAccountsARevenueBatchSch_Test{
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
        Account accSingleOrder = new Account(Name = 'singleOrder');
        Account  accMultipleOrders = new Account (Name = 'multipleOrders');
        insert new Account[]{accSingleOrder, accMultipleOrders};

        // create 2 contracts

        Contract contr1 = new Contract (AccountId = accSingleOrder.Id, ContractTerm = 24, StartDate = date.today(), Status = 'Draft');

        Contract contr2 = new Contract ( AccountId = accMultipleOrders.Id, ContractTerm = 12, StartDate = date.today(), Status = 'Draft');

        insert new Contract[]{contr1, contr2};

        // Activate contracts

        contr1.Status = 'Activated';
        contr2.Status = 'Activated';

        update contr1;
        update contr2;

         Order o1 = new Order(AccountId = accSingleOrder.Id, Status = 'Draft', Pricebook2Id = pbe.Pricebook2Id, EffectiveDate = date.today());
        insert o1;

        // insert an item
         OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=1, UnitPrice = 150);
         insert oi1;

         // update the order status to launch the trigger
         o1.Status = 'Ordered';
         update (o1);
        
        //Insert multiple orders
        Order[] orderList = new Order[]{};
        for (Integer i = 0; i < 10; i++){
            Order orderforList = new Order(AccountId = accMultipleOrders.Id, Status = 'Draft', Pricebook2Id = pbe.Pricebook2Id, EffectiveDate = date.today());
        orderList.add(orderforList);
        }
        insert orderList;
        
        //Insert orderItems
        OrderItem[] orderItemList = new OrderItem[]{};
        for(Order OrderIteration : OrderList){
            OrderItem orderItemForList = new OrderItem (OrderId = OrderIteration.Id, PricebookEntryId = pbe.Id, Quantity = 1, UnitPrice =150 );
            orderItemList.add(orderItemForList);
            OrderIteration.Status = 'Ordered';
        }
        
        insert orderItemList;
        update(orderList);

        // update accounts annual revenue with 0

        accSingleOrder.AnnualRevenue = 0;
        update (accSingleOrder);
        accMultipleOrders.AnnualRevenue = 0;
        update (accMultipleOrders);
        
        }
        @isTest
        static void updateAccountARWithSingleOrder(){
            Test.startTest();
            SchedulableContext sc = null;
            UpdateAccountARScheduler updateScheduler = new UpdateAccountARScheduler();
            updateScheduler.execute(sc);
            Test.stopTest();
            Account accAfterUpdate = [ SELECT Id, AnnualRevenue FROM Account WHERE Name = 'singleOrder'];
            System.assertEquals(150, accAfterUpdate.AnnualRevenue, 'The revenue should be 150');
        } 
        @isTest
         static void updateAccountARWithMultipleOrders(){
            Test.startTest();
            SchedulableContext sc = null;
            UpdateAccountARScheduler updateScheduler = new UpdateAccountARScheduler();
            updateScheduler.execute(sc);
            Test.stopTest();
            Account accAfterUpdate = [ SELECT Id, AnnualRevenue FROM Account WHERE Name = 'multipleOrders'];
            System.assertEquals(1500, accAfterUpdate.AnnualRevenue, 'The annual revenue should be 1500');

        } 
        
                   }