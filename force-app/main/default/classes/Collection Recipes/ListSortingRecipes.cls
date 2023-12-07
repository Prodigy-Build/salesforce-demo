public with sharing class ListSortingRecipes {
    public static void sortAccountsByShippingCountry(List<Account> accounts) {
        accounts.sort(new AccountShippingCountryComparator());
    }

    public static void sortAccountsByShippingCountryInDescending(List<Account> accounts) {
        accounts.sort(new AccountShippingCountryComparator('descending'));
    }

    public static void sortAccountsByNumberOfEmployees(List<Account> accounts) {
        accounts.sort(new AccountNumberOfEmployeesComparator());
    }
}

// Unit tests
@isTest
private class ListSortingRecipesTest {
    @isTest
    static void testSortAccountsByShippingCountry() {
        // Create test data
        List<Account> accounts = new List<Account>();
        Account acc1 = new Account(Name='Test Account 1', ShippingCountry='USA');
        Account acc2 = new Account(Name='Test Account 2', ShippingCountry='Canada');
        Account acc3 = new Account(Name='Test Account 3', ShippingCountry='Ireland');
        accounts.add(acc1);
        accounts.add(acc2);
        accounts.add(acc3);
        
        // Sort the accounts by shipping country
        ListSortingRecipes.sortAccountsByShippingCountry(accounts);
        
        // Verify the sorting order
        System.assertEquals('Canada', accounts[0].ShippingCountry, 'Incorrect sorting order');
        System.assertEquals('Ireland', accounts[1].ShippingCountry, 'Incorrect sorting order');
        System.assertEquals('USA', accounts[2].ShippingCountry, 'Incorrect sorting order');
    }
    
    @isTest
    static void testSortAccountsByShippingCountryInDescending() {
        // Create test data
        List<Account> accounts = new List<Account>();
        Account acc1 = new Account(Name='Test Account 1', ShippingCountry='USA');
        Account acc2 = new Account(Name='Test Account 2', ShippingCountry='Canada');
        Account acc3 = new Account(Name='Test Account 3', ShippingCountry='Ireland');
        accounts.add(acc1);
        accounts.add(acc2);
        accounts.add(acc3);
        
        // Sort the accounts by shipping country in descending order
        ListSortingRecipes.sortAccountsByShippingCountryInDescending(accounts);
        
        // Verify the sorting order
        System.assertEquals('USA', accounts[0].ShippingCountry, 'Incorrect sorting order');
        System.assertEquals('Ireland', accounts[1].ShippingCountry, 'Incorrect sorting order');
        System.assertEquals('Canada', accounts[2].ShippingCountry, 'Incorrect sorting order');
    }
    
    @isTest
    static void testSortAccountsByNumberOfEmployees() {
        // Create test data
        List<Account> accounts = new List<Account>();
        Account acc1 = new Account(Name='Test Account 1', NumberOfEmployees=100);
        Account acc2 = new Account(Name='Test Account 2', NumberOfEmployees=50);
        Account acc3 = new Account(Name='Test Account 3', NumberOfEmployees=200);
        accounts.add(acc1);
        accounts.add(acc2);
        accounts.add(acc3);
        
        // Sort the accounts by number of employees
        ListSortingRecipes.sortAccountsByNumberOfEmployees(accounts);
        
        // Verify the sorting order
        System.assertEquals(50, accounts[0].NumberOfEmployees, 'Incorrect sorting order');
        System.assertEquals(100, accounts[1].NumberOfEmployees, 'Incorrect sorting order');
        System.assertEquals(200, accounts[2].NumberOfEmployees, 'Incorrect sorting order');
    }
}