![entity-relationships.png](entity-relationships.png)

```mermaid
erDiagram

    Contact ||--o{ RettRelationship__c : associated
    RettPersona__c ||--o{ RettRelationship__c : associated

    Contact |o--|| Transaction__c : makes
    Contact ||--o{ Remesa_TBD : receives
    Contact ||--o{ Therapy_TBD : undergoes
    Contact ||--o{ ContactCategory__c : categorized

    ContactCategory__c ||--o{ ContactType__c : categorized

    Transaction__c ||--o{ TransactionCategory__c : categorized
    Transaction__c ||--o{ TransactionOrigin__c : originated
    TransactionCategory__c ||--o{ TransactionType__c : subcategorized

    Contact {
        id Contact__c
        string FirstName
        string MiddleName
        string LastName
        email Email
        date aesrFechaAlta__c
        date aesrFechaBaja__c
        string aesr_CuentaBancaria_NombreTitular__c
        string aesr_CuentaBancaria_NombreBanco__c
        string aesr_CuentaBancaria_IBAN__c
        Lookup(ContactCategory__c) ContactCategory__c
    }

    RettPersona__c {
        id PersonaRett__c
        string NombreCompleto
        picklist rett_Gender__c
        date rett_BirthDate__c
        bool rett_Deceased__c
        date rett_DeceaseDate__c
    }

    RettPersona__c {
        id RettPersona__c
        string Name
        string Description__c
        string(DNI) ContactID__c
        Checkbox rett_Deceased__c
        Date rett_DeceaseDate__c
        Date rett_BirthDate__c
        Picklist rett_Gender__c
        string rett_MutationInfo__c
        string Protein__c
        Picklist RettMutation__c
    }

    RettRelationship__c {
        id RettRelationship__c
        int Name
        string Descripcion__c
        Picklist Tipo__c
        Lookup(Contact) Contacts__c
        Lookup(RettPersona) RettPersona__c
    }

    RettRelationship__c {
        id RettRelationship__c
        foreign_key Contacts__c
        foreign_key RettPersona__c
        picklist Tipo__c
    }

    Transaction__c {
        id Transaction__c
        string Name
        int Amount__c
        Date Date__c
        string References__c
        Lookup(TransactionCategory) TransactionCategory__c
        Lookup(TransactionOrigin) TransactionOrigin__c
        Lookup(TransactionType) TransactionType__c
        Lookup(Contact) Contact__c
    }

    Therapy_TBD {
        string Therapy__c
        number Convocatoria__c
        string Contact__c
    }

    Remesa_TBD {
        string Remesa__c
        string RemesaId__c
        string Contact__c
    }

    ContactCategory__c {
        id ContactCategory__c
        string Name
        string DistinctColor__c
        string GroupColor__c
        string Label_ES__c
        Lookup(ContactType) ContactType__c
    }

    ContactType__c {
        id ContactType__c
        string Name
        string DistinctColor__c
        string GroupColor__c
        string Label_ES__c
    }

    TransactionCategory__c {
        id TransactionCategory__c
        string Name
        string DistinctColor__c
        string GroupColor__c
        string Label_ES__c
        Lookup(TransactionType) TransactionType__c
    }

    TransactionType__c {
        id TransactionType__c
        string Name
        string DistinctColor__c
        string GroupColor__c
        string Label_ES__c
        int TransactionSign__c
    }

    TransactionOrigin__c {
        id TransactionOrigin__c
        string Name
        string DistinctColor__c
        string GroupColor__c
        string Label_ES__c
    }


```