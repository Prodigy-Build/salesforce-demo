@isTest
public class DynamicSOQLRecipesTests {

    @isTest
    static void testSimpleDynamicSOQLQuery() {
        List<Account> accounts = DynamicSOQLRecipes.simpleDynamicSOQLQuery();
        System.assertEquals(1, accounts.size());
    }

    @isTest
    static void testSimpleBindingSOQLQuery() {
        List<Account> accounts = DynamicSOQLRecipes.simpleBindingSOQLQuery('Test Account');
        System.assertEquals(0, accounts.size());
    }

    @isTest
    static void testDynamicFieldsBindingSOQLQuery() {
        Account acct = new Account(Name = 'Test Account');
        insert acct;

        List<Account> accounts = DynamicSOQLRecipes.dynamicFieldsBindingSOQLQuery(acct);
        System.assertEquals(1, accounts.size());
    }

    @isTest
    static void testTypecastDataIntelligently() {
        List<Account> accounts = DynamicSOQLRecipes.typecastDataIntelligently('2');
        System.assertNotEquals(null, accounts);
    }

    @isTest
    static void testSimpleQueryBuilder() {
        List<String> fields = new List<String>{
            'Name',
            'NumberOfEmployees',
            'BillingAddress'
        };
        String whereClause = 'Id = \'001XXXXXXXXXXXXXXX\'';

        List<Account> accounts = DynamicSOQLRecipes.simpleQueryBuilder(fields, whereClause);
        System.assertEquals(0, accounts.size());
    }
}
