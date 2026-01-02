public class InvoiceBatch implements Database.Batchable<SObject> 
{
    private List<Invoice__c> invoices;

    
    public InvoiceBatch(List<Invoice__c> invoices)
    {
        this.invoices = invoices;
    }

    // start
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([SELECT Id, Status__c, Amount__c FROM Invoice__c WHERE Id IN :invoices]);
    }

    // execute
    public void execute(Database.BatchableContext BC, List<Invoice__c> scope)
    {
        for (Invoice__c inv : scope)
        {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://dummy-endpoint.com/api/invoice'); 
            req.setMethod('POST');
            req.setBody(JSON.serialize(inv));

            Http http = new Http();
            HttpResponse res = http.send(req); 

            inv.Status__c = 'Sent';
        }
        
        update scope; 
    } 
    //finish
    public void finish(Database.BatchableContext BC)
    {
        System.debug('All invoices have been sent');
    }
}
