@isTest
public class CalloutRecipes_Tests {
    static String goodUntypedJSON = '{"Id":"001xx000003D8FKAA0","Name":"Acme","Website":"www.acme.com","Contacts":[{"FirstName":"John","LastName":"Doe","Email":"john.doe@test.com"},{"FirstName":"Jane","LastName":"Smith","Email":"jane.smith@test.com"}]}';

    @isTest
    static void testRawCallout() {
        Test.startTest();
        String responseBody = CalloutRecipes.rawCallout();
        Test.stopTest();
        System.assertEquals('Mockbin', responseBody);
    }

    @isTest
    static void testHttpGetCalloutToSecondOrg() {
        Test.startTest();
        CalloutRecipes recipes = new CalloutRecipes('Named_Credential');
        List<Account> accounts = recipes.httpGetCalloutToSecondOrg();
        Test.stopTest();
        System.assertNotEquals(null, accounts);
    }

    @isTest
    static void testHttpDeleteCalloutToSecondOrg() {
        Test.startTest();
        CalloutRecipes recipes = new CalloutRecipes('Named_Credential');
        Integer statusCode = recipes.httpDeleteCalloutToSecondOrg('003xx000004RXRvAAO');
        Test.stopTest();
        System.assertEquals(204, statusCode);
    }

    @isTest
    static void testHttpPostCalloutToSecondOrg() {
        Test.startTest();
        List<Contact> contacts = [SELECT Id, FirstName, LastName FROM Contact LIMIT 5];
        CalloutRecipes recipes = new CalloutRecipes('Named_Credential');
        Integer statusCode = recipes.httpPostCalloutToSecondOrg(contacts);
        Test.stopTest();
        System.assertEquals(201, statusCode);
    }

    @isTest
    static void testHttpPutCalloutToSecondOrg() {
        Test.startTest();
        List<Contact> contacts = [SELECT Id, FirstName, LastName FROM Contact LIMIT 5];
        CalloutRecipes recipes = new CalloutRecipes('Named_Credential');
        Integer statusCode = recipes.httpPutCalloutToSecondOrg(contacts);
        Test.stopTest();
        System.assertEquals(200, statusCode);
    }

    @isTest
    static void testHttpPatchCalloutToSecondOrg() {
        Test.startTest();
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 5];
        CalloutRecipes recipes = new CalloutRecipes('Named_Credential');
        Integer statusCode = recipes.httpPatchCalloutToSecondOrg(accounts);
        Test.stopTest();
        System.assertEquals(200, statusCode);
    }

    @isTest
    static void testHttpCalloutWithUntypedResponse() {
        Test.startTest();
        CalloutRecipes recipes = new CalloutRecipes('Named_Credential');
        Map<String, Object> responseMap = recipes.httpCalloutWithUntypedResponse();
        Test.stopTest();
        System.assertNotEquals(null, responseMap);
    }

    @isTest
    static void testInsertAccountAndContactsFromUntypedResponse() {
        Test.startTest();
        CalloutRecipes recipes = new CalloutRecipes('Named_Credential');
        recipes.insertAccountAndContactsFromUntypedResponse(goodUntypedJSON);
        Test.stopTest();
        List<Account> accounts = [SELECT Id, Name FROM Account];
        List<Contact> contacts = [SELECT Id, FirstName, LastName FROM Contact];
        System.assertEquals(1, accounts.size());
        System.assertEquals(2, contacts.size());
    }
}