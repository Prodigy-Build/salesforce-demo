public with sharing class ApiServiceRecipesTest {
    @isTest
    static void testGetCurrentData() {
        // Create a mock response
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setStatusCode(200);
        mockResponse.setHeader('Content-Type', 'application/json');
        mockResponse.setBody('{"data": [{"id": "1", "name": "Recipe 1"}, {"id": "2", "name": "Recipe 2"}]}');

        // Create a mock HTTP mock
        HttpMock mockHttp = new HttpMock();
        mockHttp.setMockResponse(mockResponse);

        // Set the mock HTTP mock as the mock implementation
        Test.setMock(HttpCalloutMock.class, mockHttp);

        // Create an instance of the ApiServiceRecipes class
        ApiServiceRecipes asr = new ApiServiceRecipes();
        
        // Call the getCurrentData method
        List<ApiServiceRecipesDataModel> result = asr.getCurrentData();

        // Verify the result
        System.assertEquals(2, result.size());
        System.assertEquals('1', result[0].id);
        System.assertEquals('Recipe 1', result[0].name);
        System.assertEquals('2', result[1].id);
        System.assertEquals('Recipe 2', result[1].name);
    }
}