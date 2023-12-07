```java
@isTest
public class TransformSobjectsInDataWeaveTest {
    @isTest
    public static void testConvertCsvToContacts() {
        // Test data
        String inputCsv = 'Name,Email,Phone\nJohn Doe,johndoe@test.com,1234567890\nJane Smith,janesmith@test.com,9876543210';

        // Call the method
        List<Contact> contacts = TransformSobjectsInDataWeave.convertCsvToContacts(inputCsv);

        // Assert the results
        System.assertEquals(2, contacts.size());
        System.assertEquals('John Doe', contacts[0].FirstName);
        System.assertEquals('johndoe@test.com', contacts[0].Email);
        System.assertEquals('1234567890', contacts[0].Phone);
        System.assertEquals('Jane Smith', contacts[1].FirstName);
        System.assertEquals('janesmith@test.com', contacts[1].Email);
        System.assertEquals('9876543210', contacts[1].Phone);
    }

    @isTest
    public static void testConvertJsonToContacts() {
        // Test data
        String inputJson = '[{"Name":"John Doe","Email":"johndoe@test.com","Phone":"1234567890"},{"Name":"Jane Smith","Email":"janesmith@test.com","Phone":"9876543210"}]';

        // Call the method
        List<Contact> contacts = TransformSobjectsInDataWeave.convertJsonToContacts(inputJson);

        // Assert the results
        System.assertEquals(2, contacts.size());
        System.assertEquals('John Doe', contacts[0].FirstName);
        System.assertEquals('johndoe@test.com', contacts[0].Email);
        System.assertEquals('1234567890', contacts[0].Phone);
        System.assertEquals('Jane Smith', contacts[1].FirstName);
        System.assertEquals('janesmith@test.com', contacts[1].Email);
        System.assertEquals('9876543210', contacts[1].Phone);
    }
}
```