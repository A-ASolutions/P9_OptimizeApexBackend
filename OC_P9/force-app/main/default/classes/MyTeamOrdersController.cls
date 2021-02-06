/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-02-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   01-23-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public without sharing class MyTeamOrdersController {
    public decimal SumOders{
        get{
			AggregateResult groupedResults = [SELECT SUM(AnnualRevenue) total FROM Account];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}