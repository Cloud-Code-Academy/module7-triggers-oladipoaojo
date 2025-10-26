public with sharing class AccountTriggerHandler {
    public void handleBeforeInsert(List<Account> newAccounts){
        if(newAccounts == null || newAccounts.isEmpty()){
            return;

        }
        setDefaultType(newAccounts);
        copyShippingToBilling(newAccounts);
        setAccountRating(newAccounts);

    }
    private void setDefaultType(List<Account> Accounts){
        for(Account acc : Accounts){
                if(acc.Type == null){
                    acc.Type = 'Prospect';
                }
            }
        }
    private void copyShippingToBilling(List<Account> Accounts){
        for(Account acc : Accounts){
                if(acc.ShippingCountry != null){
                    acc.BillingCountry = acc.ShippingCountry;

                }if (acc.ShippingCity  != null){
                    acc.BillingCity = acc.ShippingCity;
                }if (acc.ShippingState != null){
                    acc.BillingState = acc.ShippingState;
                }if (acc.ShippingStreet != null){
                    acc.BillingStreet = acc.ShippingStreet;
                }if (acc.ShippingPostalCode != null){
                    acc.BillingPostalCode = acc.ShippingPostalCode;
                }
        }
    }
    private void setAccountRating(List<Account> Accounts){
        for(Account acc : Accounts){
                if(acc.Phone != null && acc.Website != null && acc.Fax != null){
                    acc.Rating = 'Hot';
                }
            }
        }
        // HANDLE AFTER INSERT
        Public void handleAfterInsert(List<Account> newAccounts){
            if(newAccounts == null || newAccounts.isEmpty() ){
                return;
            }
            createRelatedContacts(newAccounts);
          
        }
          private void createRelatedContacts(List<Account> accounts)
            {
                List<Contact> contactsToInstert = new List<Contact>();
                for(Account acc : accounts){
                    Contact con = new Contact();
                    con.LastName = 'DefaultContact';
                    con.FirstName = 'Default FirstName';
                    con.AccountId = acc.Id;
                    con.Email = 'default@email.com';
                    contactsToInstert.add(con);
                }
                if(!contactsToInstert.isEmpty()){
                    insert contactsToInstert;
                }
            }
}
