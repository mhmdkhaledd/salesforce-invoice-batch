trigger InvoiceTrigger on Invoice__c (after insert) {

    InvoiceTriggerHandler.handleAfterInsert(Trigger.new);
}