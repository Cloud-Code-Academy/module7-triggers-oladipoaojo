public with sharing class OpportunityTriggerHandler {
        public void handleBeforeInsert(List<Opportunity> newOpportunities ){
        if(newOpportunities == null || newOpportunities.isEmpty()){
            return;
        }
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : newOpportunities){
            if(opp.AccountId != null){
                accountIds.add(opp.AccountId);

            }
        }
            Map<Id, Contact> ceoContactMap = new Map<Id, Contact>([SELECT Id, AccountId,FirstName,LastName,Title FROM Contact WHERE Title = 'CEO' AND AccountId IN :accountIds]);
            for(Opportunity opp : newOpportunities){
                Contact ceo = ceoContactMap.get(opp.AccountId);
                if(ceo != null){
                    opp.Primary_Contact__c = ceo.Id;
            }

         }

     }
    public void handleBeforeUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunityMap){
        if(newOpportunities == null || newOpportunities.isEmpty()){
            return;
        }
        for (Opportunity opp : newOpportunities){
            Opportunity oldOpp = oldOpportunityMap.get(opp.Id);
                if((oldOpp.Amount != opp.Amount) && opp.Amount < 5000){
                    opp.addError('Opportunity amount must be greater than 5000');
            }
        }

        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : newOpportunities){
            if(opp.AccountId != null){
                accountIds.add(opp.AccountId);

            }
        }
            List<Contact> ceoContacts = [SELECT Id, AccountId,FirstName,LastName,Title FROM Contact WHERE Title = 'CEO' AND AccountId IN :accountIds];
            Map<Id, Contact> ceoContactMap = new Map<Id, Contact>();
            for(Contact con : ceoContacts){
                ceoContactMap.put(con.AccountId, con);
            }
            for(Opportunity opp : newOpportunities){
                Contact ceo = ceoContactMap.get(opp.AccountId);
                if(ceo != null){
                    opp.Primary_Contact__c = ceo.Id;
            }

         }

     }
    

    public void handleBeforeDelete(List<Opportunity> oldOpportunities){
        if(oldOpportunities == null || oldOpportunities.isEmpty()){
            return;
        }
        //All Closed Won Opportunity
        Set<Id> closedWonOpportunityAccountIds = new Set<Id>();
        for(Opportunity opp : oldOpportunities){
            if(opp.StageName == 'Closed Won' && opp.AccountId != null){
            closedWonOpportunityAccountIds.add(opp.AccountId);
        }
    }
        // check for related Accounts
        List<Account> accountsToCheck = [SELECT Id, Industry FROM Account WHERE Id IN :closedWonOpportunityAccountIds];
        Map<Id , Account> accountMap = new Map<Id, Account>(accountsToCheck);
         for(Opportunity opp : oldOpportunities){
                Account acc = accountMap.get(opp.AccountId);
                if(acc != null && acc.Industry == 'Banking' && opp.StageName == 'Closed Won'){
                    opp.addError('Cannot delete closed opportunity for a banking account that is won');
         }
      }
    }


}