trigger OpportunityTrigger on Opportunity (before insert,before update,before delete, after insert, after update, after delete, after undelete) {
    OpportunityTriggerHandler handler = new OpportunityTriggerHandler();
    if(Trigger.isbefore && Trigger.isInsert){
         handler.handleBeforeInsert(Trigger.new);
    }
    if(Trigger.isbefore && Trigger.isUpdate){   
        handler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isbefore && Trigger.isDelete){   
        handler.handleBeforeDelete(Trigger.old);
    }
    if(Trigger.isafter && Trigger.isInsert){
        
    }
    if(Trigger.isafter && Trigger.isUpdate){   
        
    }       
    if(Trigger.isafter && Trigger.isDelete){   
        
    }
    if(Trigger.isafter && Trigger.isUndelete){   
       

    }

}