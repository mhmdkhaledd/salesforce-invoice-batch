public  class TestDataFactory {
   public static List<Invoice__c> createInvoices(Integer count, String status) {
        List<Invoice__c> invoices = new List<Invoice__c>();

        for(Integer i=0; i<count; i++){
            invoices.add(new Invoice__c(
                Status__c = status,
                Amount__c = 100 + i
            ));
        }

        insert invoices;
        System.debug('Created ' + invoices.size() + ' invoices with Status = ' + status);
        return invoices;
    }
}