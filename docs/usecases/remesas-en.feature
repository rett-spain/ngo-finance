Feature: Membership fee transfers "Remesas"

    Scenario: Create new membership fee transfer
        # The application automatically identifies members with pending fee payments
        # The application allows selecting other members to include in the transfer
        # The application automatically identifies the member fee amount
        # The application generates a file in bank transfer format (SEPA)
        Given the user is in the transactions section
        When the user selects the option to create a new membership fee transfer
        And the system automatically identifies members with pending fee payments
        And the system automatically identifies the member fee amount
        And the user selects additional members to include in the transfer
        And the user confirms and saves the transfer
        Then the system generates a file in the bank transfer format (SEPA format)

    Scenario: Generate individual transactions corresponding to the member fee bank transfer from a specific format file
        Given the user is in the transactions section
        When the user selects the option to import a bank transfer
        And the user uploads the bank transfer file
        And the system processes the file and displays a summary of the imported transactions
        And the user confirms and saves the transactions
        Then the transactions are saved in the system as member fee payments

            Examples:
            # File format
            | Member ID | Member Name  | Payment Date |
            | XXXXXXXXX | Juan Pérez   | 2021-01-15   |
            | XXXXXXXXX | María López  | 2021-01-15   |
            | XXXXXXXXX | Pedro Gómez  | 2021-01-15   |