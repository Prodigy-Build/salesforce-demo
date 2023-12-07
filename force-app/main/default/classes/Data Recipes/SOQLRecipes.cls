public with sharing class TestSOQLRecipes {
    @isTest
    static void testGetRecords() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Test Account'));
        insert accounts;
        
        Test.startTest();
        List<Account> results = SOQLRecipes.getRecords();
        Test.stopTest();
        
        System.assertEquals(1, results.size());
        System.assertEquals('Test Account', results[0].Name);
    }
    
    @isTest
    static void testGetLargeNumberOfRecords() {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<201;i++){
            accounts.add(new Account(Name='Test Account '+i));
        }
        insert accounts;
        
        Test.startTest();
        Integer count = SOQLRecipes.getLargeNumberOfRecords();
        Test.stopTest();
        
        System.assertEquals(201, count);
    }
    
    @isTest
    static void testGetChunksOfLargeNumbersOfRecords() {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<201;i++){
            accounts.add(new Account(Name='Test Account '+i));
        }
        insert accounts;
        
        Test.startTest();
        Integer[] result = SOQLRecipes.getChunksOfLargeNumbersOfRecords();
        Test.stopTest();
        
        System.assertEquals(1, result[0]);
        System.assertEquals(201, result[1]);
    }
    
    @isTest
    static void testGetRecordsByFieldValue() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Test Account', ShippingCountry='UK'));
        accounts.add(new Account(Name='Test Account 2', ShippingCountry='US'));
        insert accounts;
        
        Test.startTest();
        List<Account> results = SOQLRecipes.getRecordsByFieldValue();
        Test.stopTest();
        
        System.assertEquals(1, results.size());
        System.assertEquals('Test Account', results[0].Name);
    }
    
    @isTest
    static void testGetRecordsByMultipleFieldValues() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Test Account', ShippingCountry='US', ShippingState='IN', Industry='Fast Food - made whole'));
        accounts.add(new Account(Name='Test Account 2', ShippingCountry='US', ShippingState='IN', Industry='Slow Food - Made quickly'));
        accounts.add(new Account(Name='Test Account 3', ShippingCountry='UK', ShippingState='NY', Industry='Fast Food - made whole'));
        insert accounts;
        
        Test.startTest();
        List<Account> results = SOQLRecipes.getRecordsByMultipleFieldValues();
        Test.stopTest();
        
        System.assertEquals(2, results.size());
        System.assertEquals('Test Account', results[0].Name);
        System.assertEquals('Test Account 2', results[1].Name);
    }
    
    @isTest
    static void testGetSpecificNumberOfRecords() {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<15;i++){
            accounts.add(new Account(Name='Test Account '+i));
        }
        insert accounts;
        
        Test.startTest();
        List<Account> results = SOQLRecipes.getSpecificNumberOfRecords();
        Test.stopTest();
        
        System.assertEquals(10, results.size());
        System.assertEquals('Test Account 4', results[4].Name);
    }
    
    @isTest
    static void testGetFirstXRecords() {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<15;i++){
            accounts.add(new Account(Name='Test Account '+i));
        }
        insert accounts;
        
        Test.startTest();
        List<Account> results = SOQLRecipes.getFirstXRecords(5);
        Test.stopTest();
        
        System.assertEquals(5, results.size());
        System.assertEquals('Test Account 4', results[4].Name);
    }
    
    @isTest
    static void testGetAccountRecordsInState() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Test Account', ShippingState='KS'));
        accounts.add(new Account(Name='Test Account 2', ShippingState='NY'));
        insert accounts;
        
        Test.startTest();
        List<Account> results = SOQLRecipes.getAccountRecordsInState('KS');
        Test.stopTest();
        
        System.assertEquals(1, results.size());
        System.assertEquals('Test Account', results[0].Name);
    }
    
    @isTest
    static void testGetSecond10AccountRecords() {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<20;i++){
            accounts.add(new Account(Name='Test Account '+i));
        }
        insert accounts;
        
        Test.startTest();
        List<Account> results = SOQLRecipes.getSecond10AccountRecords();
        Test.stopTest();
        
        System.assertEquals(10, results.size());
        System.assertEquals('Test Account 10', results[0].Name);
    }
    
    @isTest
    static void testGetRecordsWithRelatedRecords() {
        Account account = new Account();
        account.Name = 'Test Account';
        insert account;
        
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(AccountId=account.Id, FirstName='John', LastName='Doe'));
        contacts.add(new Contact(AccountId=account.Id, FirstName='Jane', LastName='Smith'));
        insert contacts;
        
        Test.startTest();
        List<Account> results = SOQLRecipes.getRecordsWithRelatedRecords();
        Test.stopTest();
        
        System.assertEquals(1, results.size());
        System.assertEquals('Test Account', results[0].Name);
        System.assertEquals(2, results[0].Contacts.size());
        System.assertEquals('John', results[0].Contacts[0].FirstName);
        System.assertEquals('Jane', results[0].Contacts[1].FirstName);
    }
    
    @isTest
    static void testGetParentRecordDetailsFromChildRecord() {
        Account account = new Account();
        account.Name = 'Test Account';
        account.ShippingState = 'KS';
        insert account;
        
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'John';
        contact.LastName = 'Doe';
        insert contact;
        
        Test.startTest();
        List<Contact> results = SOQLRecipes.getParentRecordDetailsFromChildRecord();
        Test.stopTest();
        
        System.assertEquals(1, results.size());
        System.assertEquals('John', results[0].FirstName);
        System.assertEquals('Test Account', results[0].Account.Name);
        System.assertEquals('KS', results[0].Account.ShippingState);
    }
    
    @isTest
    static void testGetDetailsFromBothParentRecords() {
        Account parent1 = new Account();
        parent1.Name = 'Parent Account 1';
        insert parent1;
        
        Account parent2 = new Account();
        parent2.Name = 'Parent Account 2';
        insert parent2;
        
        Junction__c junction = new Junction__c();
        junction.parent1__c = parent1.Id;
        junction.parent2__c = parent2.Id;
        insert junction;
        
        Test.startTest();
        List<Junction__c> results = SOQLRecipes.getDetailsFromBothParentRecords();
        Test.stopTest();
        
        System.assertEquals(1, results.size());
        System.assertEquals('Parent Account 1', results[0].parent1__r.Name);
        System.assertEquals('Parent Account 2', results[0].Parent2__r.Name);
    }
    
    @isTest
    static void testGetSumOfOpportunityRecords() {
        Account account = new Account();
        account.Name = 'Test Account';
        insert account;
        
        Opportunity opportunity1 = new Opportunity();
        opportunity1.AccountId = account.Id;
        opportunity1.Amount = 100;
        insert opportunity1;
        
        Opportunity opportunity2 = new Opportunity();
        opportunity2.AccountId = account.Id;
        opportunity2.Amount = 200;
        insert opportunity2;
        
        Test.startTest();
        Double total = SOQLRecipes.getSumOfOpportunityRecords(account.Id);
        Test.stopTest();
        
        System.assertEquals(300.0, total);
    }
}
