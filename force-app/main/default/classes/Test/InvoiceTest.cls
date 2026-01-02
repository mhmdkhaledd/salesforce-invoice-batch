@isTest
public class InvoiceTest {

   
    // test batch in normal case
    @isTest
    static void testInvoiceBatch() {

        List<Invoice__c> invoices = TestDataFactory.createInvoices(5, 'Pending');

        Test.startTest();
        Database.executeBatch(new InvoiceBatch([SELECT Id FROM Invoice__c WHERE Status__c='Pending']));
        Test.stopTest();

        List<Invoice__c> updated = [SELECT Status__c FROM Invoice__c WHERE Id IN :invoices];
        for(Invoice__c inv : updated){
            System.assertEquals('Sent', inv.Status__c, 'invoice sataus should be Sent');
        }
    }

    //  Test Invoice not Pending 
    @isTest
    static void testInvoiceNotPending() {

        Invoice__c inv = TestDataFactory.createInvoices(1, 'Failed')[0];

        Test.startTest();
        Database.executeBatch(new InvoiceBatch([SELECT Id FROM Invoice__c WHERE Status__c='Pending']));
        Test.stopTest();

        Invoice__c check = [SELECT Status__c FROM Invoice__c WHERE Id=:inv.Id];
        System.assertEquals('Failed', check.Status__c, 'invoice sataus should be Failed');
    }

    
    // Test Batch with HTTP Callout (Mock)
    @isTest
    static void testInvoiceBatchWithCallout() {

        Invoice__c inv = TestDataFactory.createInvoices(1, 'Pending')[0];

        // Mock Callout
        Test.setMock(HttpCalloutMock.class, new MockAccountingCallout());

        Test.startTest();
        Database.executeBatch(new InvoiceBatch([SELECT Id FROM Invoice__c WHERE Status__c='Pending']));
        Test.stopTest();

        Invoice__c check = [SELECT Status__c FROM Invoice__c WHERE Id=:inv.Id];
        System.assertEquals('Sent', check.Status__c,'callout should be success');
    }
}