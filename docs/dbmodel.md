```mermaid
erDiagram

    Contact ||--o{ RettRelationship : Contact__c
    PersonaRett ||--o{ RettRelationship : PersonaRett__c

    Contact |o--|| Transaction : Contact__c
    Contact ||--o{ Remesa : Contact__c
    Contact ||--o{ Therapy : Contact__c



    Contact {
        string FirstName
        string MiddleName
        string LastName
        email Email
        picklist ContactType__c
        date aesrFechaAlta__c
        date aesrFechaBaja__c
        string aesr_CuentaBancaria_NombreTitular__c
        string aesr_CuentaBancaria_NombreBanco__c
        string aesr_CuentaBancaria_IBAN__c
    }

    PersonaRett {
        string NombreCompleto
        string ContactID__c
        picklist rett_Gender__c
        date rett_BirthDate__c
        bool rett_Deceased__c
        date rett_DeceaseDate__c
    }

    RettRelationship {
        id Contacts__c
        id RettPersona__c
        picklist Tipo__c
    }

    Transaction {
        int Amount__c
        picklist Category__c
        date Date__c
        string Name
        id Contact__c
        id PersonaRett__c
        calculated TransactionOwnerId__c
        calculated TransactionOwnerType__c
    }

    Therapy {
        id TherapyId__c
        number Convocatoria__c
        id Contact__c
    }

    Remesa {
        id RemesaRecord__c
        string RemesaId__c
        id Contact__c
    }

```