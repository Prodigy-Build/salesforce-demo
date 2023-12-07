// Unit tests for CollectionUtils class

@IsTest
private class CollectionUtilsTest {
    @IsTest
    static void testIdMapFromCollectionByKey() {
        // Test data
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact contact = new Contact(
                AccountId = (i % 2 == 0) ? '001' : '002',
                FirstName = 'First' + i,
                LastName = 'Last' + i
            );
			contacts.add(contact);
        }
        
        // Test execution
        Map<Id, Contact> contactsByAccountId = CollectionUtils.idMapFromCollectionByKey('AccountId', contacts);
        
        // Assertions
        System.assertEquals(3, contactsByAccountId.size());
        System.assertEquals('001', contactsByAccountId.get('001').AccountId);
        System.assertEquals('002', contactsByAccountId.get('002').AccountId);
        System.assertEquals(5, contactsByAccountId.get('001').size());
        System.assertEquals(5, contactsByAccountId.get('002').size());
    }
    
    @IsTest
    static void testStringMapFromCollectionByKey() {
        // Test data
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact contact = new Contact(
                ShippingStreet = 'Street ' + i,
                FirstName = 'First' + i,
                LastName = 'Last' + i
            );
            contacts.add(contact);
        }
        
        // Test execution
        Map<String, Contact> contactsByShippingStreet = CollectionUtils.stringMapFromCollectionByKey('ShippingStreet', contacts);
        
        // Assertions
        System.assertEquals(5, contactsByShippingStreet.size());
        System.assertEquals('Street 0', contactsByShippingStreet.get('Street 0').ShippingStreet);
        System.assertEquals('Street 1', contactsByShippingStreet.get('Street 1').ShippingStreet);
        System.assertEquals(1, contactsByShippingStreet.get('Street 0').size());
        System.assertEquals(1, contactsByShippingStreet.get('Street 1').size());
    }
    
    @IsTest
    static void testMapFromCollectionWithCollectionValues() {
        // Test data
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact contact = new Contact(
                AccountId = (i % 2 == 0) ? '001' : '002',
                FirstName = 'First' + i,
                LastName = 'Last' + i
            );
            contacts.add(contact);
        }
        
        // Test execution
        Map<Id, List<Contact>> contactsByAccountId = CollectionUtils.mapFromCollectionWithCollectionValues('AccountId', contacts);
        
        // Assertions
        System.assertEquals(2, contactsByAccountId.size());
        System.assertEquals(5, contactsByAccountId.get('001').size());
        System.assertEquals(5, contactsByAccountId.get('002').size());
    }
}