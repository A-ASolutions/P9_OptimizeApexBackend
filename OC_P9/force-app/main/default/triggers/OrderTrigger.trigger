/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-25-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   01-24-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
trigger OrderTrigger on Order (before update ,after update) {
	
    // update account anuual revenue

    if (Trigger.isAfter){
        List <Order> triggerOrder =  Trigger.new;
        
    }
    }
}