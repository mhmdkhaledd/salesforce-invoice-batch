public  class InvoiceTriggerHandler {
    public static void handleAfterInsert(List<Invoice__c>newInvoices ) {

        List <Invoice__c> pendingInvoices = new List<Invoice__c>();
        for (Invoice__c inv : newInvoices) {
            if (inv.Status__c == 'Pending') {
                pendingInvoices.add(inv);
            }
        }
        if (!pendingInvoices.isEmpty()) {
        
        InvoiceBatch batch = new InvoiceBatch(pendingInvoices);
        Database.executeBatch(batch);
    }
    }

    
}