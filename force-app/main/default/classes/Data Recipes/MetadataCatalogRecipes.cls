// Unit tests for MetadataCatalogRecipes

@isTest
private class MetadataCatalogRecipesTest {
    // Test for findAllFormulaFields method
    @isTest
    static void testFindAllFormulaFields() {
        // Create test data
        EntityDefinition entity = new EntityDefinition(QualifiedApiName = 'Test_Object__c');
        FieldDefinition field1 = new FieldDefinition(DeveloperName = 'Field1', DataType = 'Number', IsCalculated = true);
        FieldDefinition field2 = new FieldDefinition(DeveloperName = 'Field2', DataType = 'Text', IsCalculated = false);
        List<FieldDefinition> fields = new List<FieldDefinition>{field1, field2};
        entity.Fields = fields;
        List<EntityDefinition> entities = new List<EntityDefinition>{entity};

        // Insert test data
        Test.startTest();
        Database.insert(entities);
        Test.stopTest();

        // Call the method to test
        Map<String, Map<String, String>> results = MetadataCatalogRecipes.findAllFormulaFields();

        // Verify the results
        System.assertEquals(1, results.size());
        System.assertEquals(1, results.get('Test_Object__c').size());
        System.assertEquals('Number', results.get('Test_Object__c').get('Field1'));
    }

    // Test for findAllContactFieldsThatLookupToAccount method
    @isTest
    static void testFindAllContactFieldsThatLookupToAccount() {
        // Create test data
        FieldDefinition field = new FieldDefinition(EntityDefinition = new EntityDefinition(DeveloperName = 'Contact'), DeveloperName = 'LookupField', DataType = 'Lookup(Contact)');
        List<FieldDefinition> fields = new List<FieldDefinition>{field};

        // Insert test data
        Test.startTest();
        Database.insert(fields);
        Test.stopTest();

        // Call the method to test
        List<MetadataCatalogRecipes.LookupRelationshipDefinition> results = MetadataCatalogRecipes.findAllContactFieldsThatLookupToAccount();

        // Verify the results
        System.assertEquals(1, results.size());
        MetadataCatalogRecipes.LookupRelationshipDefinition result = results[0];
        System.assertEquals('Contact', result.looksUpTo);
        System.assertEquals('LookupField', result.developerName);
        System.assertEquals('Lookup(Contact)', result.relationshipName);
        System.assertEquals('Lookup(Contact)', result.dataType);
    }
}