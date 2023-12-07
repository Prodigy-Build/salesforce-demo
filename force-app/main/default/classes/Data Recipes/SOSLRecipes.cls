public with sharing class SOSLRecipes {
    public static List<List<SObject>> basicSOSLSearch() {
        String keyword = 'Kan*';
        List<List<SObject>> searchResults = [
            FIND :keyword
            IN ALL FIELDS
            RETURNING account(name), contact(lastname, account.Name)
        ];

        return searchResults;
    }

    public static List<List<SObject>> nameFieldSearch() {
        String keyword = 'Alaska';
        List<List<SObject>> searchResults = [
            FIND :keyword
            IN NAME FIELDS
            RETURNING account(name), contact(lastname, account.Name)
        ];
        return searchResults;
    }
}

// Unit Tests for SOSLRecipes class
@isTest
public class SOSLRecipes_Tests {
    @isTest
    static void testBasicSOSLSearch() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        Contact testContact = new Contact(LastName = 'Test Contact', AccountId = testAccount.Id);
        insert testAccount;
        insert testContact;
        
        // Prepare the fixed search results
        List<List<SObject>> expectedSearchResults = new List<List<SObject>>();
        List<SObject> accountResults = new List<SObject>();
        accountResults.add(testAccount);
        List<SObject> contactResults = new List<SObject>();
        contactResults.add(testContact);
        expectedSearchResults.add(accountResults);
        expectedSearchResults.add(contactResults);
        
        // Set the fixed search results
        Test.setFixedSearchResults(expectedSearchResults);
        
        // Perform the search using the SOSLRecipes class
        List<List<SObject>> actualSearchResults = SOSLRecipes.basicSOSLSearch();
        
        // Verify the search results
        System.assertEquals(expectedSearchResults, actualSearchResults);
    }
    
    @isTest
    static void testNameFieldSearch() {
        // Create test data
        Account testAccount = new Account(Name = 'Alaska Account');
        Contact testContact = new Contact(LastName = 'Test Contact', AccountId = testAccount.Id);
        insert testAccount;
        insert testContact;
        
        // Prepare the fixed search results
        List<List<SObject>> expectedSearchResults = new List<List<SObject>>();
        List<SObject> accountResults = new List<SObject>();
        accountResults.add(testAccount);
        expectedSearchResults.add(accountResults);
        
        // Set the fixed search results
        Test.setFixedSearchResults(expectedSearchResults);
        
        // Perform the search using the SOSLRecipes class
        List<List<SObject>> actualSearchResults = SOSLRecipes.nameFieldSearch();
        
        // Verify the search results
        System.assertEquals(expectedSearchResults, actualSearchResults);
    }
}