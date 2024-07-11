import csv
from simple_salesforce import Salesforce
from simple_salesforce.exceptions import SalesforceMalformedRequest


class SalesForceAPI:
    def __init__(self, username, password, security_token):
        self.username = username
        self.password = password
        self.security_token = security_token
        self.sf = None

    # Authenticate to Salesforce
    def authenticate(self):
        try:
            self.sf = Salesforce(username=self.username,
                                 password=self.password,
                                 security_token=self.security_token)
            return True
        except Exception as e:
            print(e)
            return False

    # Upload a list of donations to Salesforce
    def upload_donations(self, donations):
        for donation in donations:
            # check if contact exists in Salesforce
            if self.contact_exists(donation["contact_id"]):
                # upload Donation to Salesforce
                self.upload_donation(donation)
                print(f'Uploaded donation of {donation["donation_amount"]} " \
                      "for contact with ID {donation["contact_id"]}')
            else:
                print(f'Contact with ID {donation["contact_id"]} does not exist in Salesforce')

    # Upload a single donation to Salesforce
    def upload_donation(self, donation):
        try:
            opportunity = self.sf.Opportunity.create({'npsp__Primary_Contact__c': donation["contact_id"],
                                                      'Name': donation["donation_name"],
                                                      'Amount': donation["donation_amount"],
                                                      'StageName': donation["stage_name"],
                                                      'CloseDate': donation["close_date"].strftime('%Y-%m-%d'),
                                                      'Type': donation["donation_type"],
                                                      'aesr_DonationCategory__c': donation["donation_category"]})
            donation["donation_id"] = opportunity['id']
            self.sf.OpportunityContactRole.create({'OpportunityId': donation["donation_id"],
                                                   'ContactId': donation["contact_id"]})
        except SalesforceMalformedRequest as e:
            print(e)

        return True

    # Check if the contact exists in Salesforce and retrieve the Contact ID and other information related with the contact
    def contact_exists(self, contact_id):
        query = "SELECT Id, FirstName, MiddleName, LastName, Email FROM Contact WHERE Id = '{}'".format(contact_id)
        result = self.sf.query(query)

        # Check if only 1 contact records is returned, otherwise return False
        if result['totalSize'] == 1:
            # Extract the first Contact record from the result set
            return True
        else:
            return False

    # Retrieve contact information from Salesforce based on the contact ID
    def get_contact_byid(self, contact):
        query = "SELECT Id, FirstName, MiddleName, LastName, Email FROM Contact WHERE Id = '{}'".format(contact.contact_id)
        result = self.sf.query(query)

        # Check if only 1 contact records is returned, otherwise return False
        if result['totalSize'] == 1:
            # Extract the first Contact record from the result set
            contact.contact_id = result['records'][0]['Id']
            contact.first_name = result['records'][0]['FirstName']
            contact.middle_name = result['records'][0]['MiddleName']
            contact.last_name = result['records'][0]['LastName']
            contact.email = result['records'][0]['Email']

            return True
        else:
            return False

    # Retrieve contact information from Salesforce based on the contact email address
    def get_contact_byemail(self, contact):
        query = "SELECT Id, FirstName, MiddleName, LastName, Email FROM Contact WHERE Email = '{}'".format(contact.email_address)
        result = self.sf.query(query)

        # Check if only 1 contact records is returned, otherwise return False
        if result['totalSize'] == 1:
            # Extract the first Contact record from the result set
            contact.contact_id = result['records'][0]['Id']
            contact.first_name = result['records'][0]['FirstName']
            contact.middle_name = result['records'][0]['MiddleName']
            contact.last_name = result['records'][0]['LastName']
            contact.email_address = result['records'][0]['Email']

            return True
        else:
            return False

    # Check if there is a unique contact ID from Salesforce based on the contact email address
    def get_contactid_byemail(self, email_address):
        query = "SELECT Id FROM Contact WHERE Email = '{}'".format(email_address)
        result = self.sf.query(query)

        # Check if only 1 contact records is returned, otherwise return False
        if result['totalSize'] == 1:
            # Extract the first Contact record from the result set
            return result['records'][0]['Id']
        elif result['totalSize'] > 1:
            # Several contacts with the same email address
            return False
        else:
            return None

    # Get all contact id from Salesforce based on a list with several email address
    def get_contactids_byemail(self, email_address_list):
        email_to_contact_id = {}
        for email_address in email_address_list:
            contact_id = self.get_contactid_byemail(email_address)
            if contact_id:
                email_to_contact_id[email_address] = contact_id

        return email_to_contact_id

    # Get contact id based on first, middle and last name
    def get_contactid_byname(self, contact_name):
        query = "SELECT Id FROM Contact WHERE Name = '{}'".format(contact_name)
        result = self.sf.query(query)

        # Check if only 1 contact records is returned, otherwise return False
        if result['totalSize'] == 1:
            # Extract the first Contact record from the result set
            return result['records'][0]['Id']
        elif result['totalSize'] > 1:
            # Several contacts with the same name
            return False
        else:
            return None

    # Get all contact id from Salesforce based on a list with several first, middle and last name
    def get_contactids_byname(self, contact_name_list):
        name_to_contact_id = {}
        for contact_name in contact_name_list:
            contact_id = self.get_contactid_byname(contact_name)
            if contact_id:
                name_to_contact_id[contact_name] = contact_id

        return name_to_contact_id

    # Get contact id based on generic information using SOSL query
    def get_contactid_bygeneric(self, generic_info):
        # Examples of SOSL queries
        query = "FIND {Pedro} IN Name Fields RETURNING Contact(Id, FirstName, LastName, Phone, Email)"
        search_terms = ['Pedro']
        query = 'FIND {{{0}}} IN Name Fields RETURNING Contact(Id, FirstName, LastName, Phone, Email)'.format('}, {'.join(search_terms))
        query = "FIND {Pedro Jorge} IN Name Fields RETURNING Contact(Id, FirstName, LastName, Phone, Email)"
        query = "FIND {Fernan*} IN Name Fields RETURNING Contact(Id, FirstName, LastName, Phone, Email)"
        query = 'FIND {{{0}}} IN Name Fields RETURNING Contact(Id, FirstName, LastName, Phone, Email)'.format('}, {'.join(generic_info.split(' ')))
        query = 'FIND {{{0}}} IN ALL Fields RETURNING Contact(Id, Name, Phone, Email, ContactType__c, SituacionTesoreria__c, aesrFechaAlta__c, aesrFechaBaja__c)'.format('}, {'.join(generic_info.split(' ')))
        query = f'FIND {{{generic_info}}} IN ALL Fields RETURNING Contact(Id, Name, Phone, Email, ContactType__c, SituacionTesoreria__c, aesrFechaAlta__c, aesrFechaBaja__c)'

        # Search in all fields and return main contact information
        query = 'FIND {' + ' OR '.join(generic_info.split()) + '} IN ALL Fields RETURNING Contact(Id, Name, Phone, Email, ContactType__c, SituacionTesoreria__c, aesrFechaAlta__c, aesrFechaBaja__c)'

        # Execute the search
        result = self.sf.search(query)

        # Return the result of the search
        return result

    # Bulk export contacts to a CSV file
    def export_contacts_to_csv(self, file_path):
        query = "SELECT Id, ContactType__c, FirstName, MiddleName, LastName, Name, Email, aesr_CuentaBancaria_NombreTitular__c, aesr_CuentaBancaria_NombreBanco__c, aesr_CuentaBancaria_IBAN__c, aesrCuotaSocio__c FROM Contact"
        result = self.sf.query_all(query)

        contacts = result['records']
        fieldnames = contacts[0].keys()

        with open(file_path, mode='w', newline='') as file:
            writer = csv.DictWriter(file, fieldnames=fieldnames)
            writer.writeheader()
            for contact in contacts:
                writer.writerow(contact)
                
        print(f"Exported {len(contacts)} contacts to {file_path}")

    # Bulk simple export contacts to a CSV file
    def export_basic_contact_info_to_csv(self, file_path):
        query = "SELECT Id, ContactType__c, ContactCategory__c, FirstName, MiddleName, LastName, Name, Email FROM Contact"
        result = self.sf.query_all(query)

        contacts = result['records']
        fieldnames = contacts[0].keys()

        with open(file_path, mode='w', newline='') as file:
            writer = csv.DictWriter(file, fieldnames=fieldnames)
            writer.writeheader()
            for contact in contacts:
                writer.writerow(contact)
                
        print(f"Exported {len(contacts)} contacts to {file_path}")

    # Generic bulk export to a CSV file
    def export_to_csv(self, file_path, soql_query):
        result = self.sf.query_all(soql_query)

        contacts = result['records']
        fieldnames = contacts[0].keys()

        with open(file_path, mode='w', newline='') as file:
            writer = csv.DictWriter(file, fieldnames=fieldnames)
            writer.writeheader()
            for contact in contacts:
                writer.writerow(contact)
                
        print(f"Exported {len(contacts)} contacts to {file_path}")

    # Execute a SOQL query
    def execute_soql_query(self, query):
        result = self.sf.query_all(query)
        return result

    # Bulk import transactions to Salesforce (Transaction__c object)
    def bulk_import_transactions(self, records):
        try:
            self.sf.bulk.Transaction__c.insert(records)
            print(f'Uploaded {len(records)} transactions')
        except SalesforceMalformedRequest as e:
            print(e)
            return False

        return True