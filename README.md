# Invoice Management System (Salesforce Apex)

This Salesforce project demonstrates a simple invoice management system using Apex triggers, batch classes, and HTTP callouts. It includes test classes and mock callouts for proper testing.

---

## Project Structure

### 1. `InvoiceTriggerHandler`
Handles the logic after inserting new invoices.  
- Filters invoices with `Status__c = 'Pending'`.  
- Executes the `InvoiceBatch` to send pending invoices.

### 2. `InvoiceTrigger`
A trigger on `Invoice__c` (after insert) that calls `InvoiceTriggerHandler.handleAfterInsert`.

### 3. `InvoiceBatch`
A batch class that processes a list of invoices.  
- Sends each invoice to an external endpoint via HTTP POST.  
- Updates the invoice status to `'Sent'`.  
- Implements `Database.Batchable<SObject>` methods: `start`, `execute`, and `finish`.

### 4. `TestDataFactory`
A helper class to generate test invoices.  
- Method: `createInvoices(Integer count, String status)`  
- Creates and inserts a list of invoices with the given status.

### 5. `InvoiceTest`
Test class for the invoice system.  
- Tests normal batch processing.  
- Tests invoices that are not pending.  
- Tests batch with HTTP callout using a mock.

### 6. `MockAccountingCallout`
A mock class for HTTP callouts during tests.  
- Implements `HttpCalloutMock`.  
- Returns a successful JSON response with status 200.

---

