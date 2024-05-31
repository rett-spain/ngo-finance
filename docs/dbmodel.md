
```mermaid
erDiagram
    TRANSACTION ||--|{ CONTACT : contains
    TRANSACTION {
        int Amount__c
        picklist Category__c
        date Date__c
        string Name
        calculated TransactionOwnerId__c
        calculated TransactionOwnerType__c
    }
    CONTACT {
        string FirstName
        string MiddleName
        string LastName
        email Email
        picklist ContactType__c
    }
```