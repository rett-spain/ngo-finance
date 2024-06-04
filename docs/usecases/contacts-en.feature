Feature: Contact Management

    Scenario: List contacts
    Given the user is on the home page
    When the user accesses the contacts section
    Then the user sees a list of contacts sorted alphabetically
    # List columns: Name and Surname, Contact type, Phone, Email

    Scenario: Search contacts
    Given the user is in the contacts section
    When the user searches for a contact
    Then the user sees a list of contacts that match the search
    # Search by Name and Surname, Contact type, Phone, Email

    Scenario: View contact details
    Given the user is in the contacts section
    When the user selects a contact by double-clicking on the contact in the list
    Then a detail sheet opens and the user sees the contact's details
    # What details are of interest to show?

    Scenario: View Rett persons associated with a contact
    Given the user is in the contacts section
    When the user selects a contact by double-clicking on the contact in the list
    Then a detail sheet opens and the user sees a list of Rett persons associated with the contact

    Scenario: View transactions associated with a contact
    Given the user is in the contacts section
    When the user selects a contact by double-clicking on the contact in the list
    Then the user sees a list of transactions associated with the contact
    # It might make sense to provide different actions to the user:
    # (view contact details, view transactions, list of Rett persons associated with this contact, etc.)

    @fee
    Scenario: See if a contact is up to date with payments
    Given the user is in the contacts section
    When the user selects a contact
    Then the user sees if the contact is up to date with the annual fee payments

    Scenario: View the list of members up to date with payments
    Given the user is in the contacts section
    When the user accesses the contacts section
    Then the user sees a list of members up to date with the annual fee payments

    Scenario: Edit the contact type
    Given the user is in the contacts section
    When the user selects a contact
    Then the user can edit the contact type
    # Only certain contact details will be allowed to be edited

        Examples:
        | contact type       |
        | Regular member     |
        | Supporting member  |
        | Individual donor   |
        | Corporate donor    |
        | Non-member         |
        | Deactivated        |

    Scenario: Deactivate a contact
    Given the user is in the contacts section
    When the user selects a contact
    Then the user can deactivate the contact by changing the contact type to "Deactivated" and must enter a deactivation date