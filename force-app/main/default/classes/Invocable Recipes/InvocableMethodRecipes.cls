// Unit tests for InvocableMethodRecipes class
@isTest
private class InvocableMethodRecipesTest {
    
    @testSetup
    static void setup() {
        // Create test data
        Account account = new Account(Name='Test Account');
        insert account;
        
        Task task = new Task(Subject='Test Task', WhoId=account.Id);
        insert task;
        
        Contact contact = new Contact(AccountId=account.Id, FirstName='John', LastName='Doe');
        insert contact;
    }
    
    @isTest
    static void testFindRelatedContacts_Account() {
        // Create ContactSearchRequest with Account record
        InvocableMethodRecipes.ContactSearchRequest request = new InvocableMethodRecipes.ContactSearchRequest();
        request.inputs = new List<SObject>{[SELECT Id, Name FROM Account LIMIT 1]};
        
        // Call findRelatedContacts method
        List<InvocableMethodRecipes.ContactSearchResult> results = InvocableMethodRecipes.findRelatedContacts(new List<InvocableMethodRecipes.ContactSearchRequest>{request});
        
        // Ensure results contain the expected Contact
        System.assertEquals(1, results.size());
        System.assertEquals('John', ((Contact)results[0].output).FirstName);
        System.assertEquals('Doe', ((Contact)results[0].output).LastName);
    }
    
    @isTest
    static void testFindRelatedContacts_Task() {
        // Create ContactSearchRequest with Task record
        InvocableMethodRecipes.ContactSearchRequest request = new InvocableMethodRecipes.ContactSearchRequest();
        request.inputs = new List<SObject>{[SELECT Id, WhoId FROM Task LIMIT 1]};
        
        // Call findRelatedContacts method
        List<InvocableMethodRecipes.ContactSearchResult> results = InvocableMethodRecipes.findRelatedContacts(new List<InvocableMethodRecipes.ContactSearchRequest>{request});
        
        // Ensure results contain the expected Contact
        System.assertEquals(1, results.size());
        System.assertEquals('John', ((Contact)results[0].output).FirstName);
        System.assertEquals('Doe', ((Contact)results[0].output).LastName);
    }
    
    @isTest
    static void testFindRelatedContacts_UnknownObjectType() {
        // Create ContactSearchRequest with unsupported object type
        InvocableMethodRecipes.ContactSearchRequest request = new InvocableMethodRecipes.ContactSearchRequest();
        request.inputs = new List<SObject>{[SELECT Id, Name FROM Opportunity LIMIT 1]};
        
        // Call findRelatedContacts method and ensure exception is thrown
        try {
            List<InvocableMethodRecipes.ContactSearchResult> results = InvocableMethodRecipes.findRelatedContacts(new List<InvocableMethodRecipes.ContactSearchRequest>{request});
            System.assert(false, 'Expected exception was not thrown.');
        } catch (InvocableMethodRecipes.InvocableMethodRecipesException e) {
            System.assertEquals('Unknown object type passed. This method only supports Account and Task.', e.getMessage());
        }
    }
}