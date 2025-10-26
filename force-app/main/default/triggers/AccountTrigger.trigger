trigger AccountTrigger on Account (before insert,after insert, before update, after update, before delete, after delete, after undelete) {

    AccountTriggerHandler handler = new AccountTriggerHandler();
    if(Trigger.isbefore && Trigger.isInsert){
        handler.handleBeforeInsert(Trigger.new);
    }
     if(Trigger.isbefore && Trigger.isUpdate){

    }
     if(Trigger.isbefore && Trigger.isDelete){

    }
    if(Trigger.isafter && Trigger.isInsert){
        handler.handleAfterInsert(Trigger.new);
        }
    if(Trigger.isafter && Trigger.isUpdate){
    
        }
    if(Trigger.isafter && Trigger.isDelete){
    
        }
    if(Trigger.isafter && Trigger.isUndelete){
    
        }


}