// Unit tests for LDVRecipes class

@IsTest
private class LDVRecipesTest {
    @TestVisible
    private class TestQueueableContext implements System.QueueableContext {
        public Boolean isExecuteNext;
    }

    @IsTest
    static void testConstructorWithoutOffsetId() {
        LDVRecipes recipes = new LDVRecipes();
        List<ContentDocumentLink> recordsToProcess = (List<ContentDocumentLink>) Test.getPrivateData(recipes, 'objectsToProcess');
        
        System.assertEquals(20, recordsToProcess.size());
    }

    @IsTest
    static void testConstructorWithOffsetId() {
        Id offsetId = 'ExampleOffsetId';
        LDVRecipes recipes = new LDVRecipes(offsetId);
        List<ContentDocumentLink> recordsToProcess = (List<ContentDocumentLink>) Test.getPrivateData(recipes, 'objectsToProcess');
        
        System.assertEquals(offsetId, recipes.offsetId);
        System.assertEquals(20, recordsToProcess.size());
    }

    @IsTest
    static void testExecute() {
        LDVRecipes recipes = new LDVRecipes();
        TestQueueableContext queueableContext = new TestQueueableContext();
        recipes.execute(queueableContext);

        System.assertEquals(1, LDVRecipes.chunksExecuted);
    }

    @IsTest
    static void testGetRecordsToProcess() {
        Id offsetId = 'ExampleOffsetId';
        LDVRecipes recipes = new LDVRecipes(offsetId);
        List<ContentDocumentLink> recordsToProcess = recipes.getRecordsToProcess(offsetId);

        System.assertNotEquals(null, recordsToProcess);
    }
}