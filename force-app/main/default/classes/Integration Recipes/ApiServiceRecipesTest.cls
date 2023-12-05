public with sharing class ApiServiceRecipes extends RestClient {

    @testVisible
    private static final String DEFAULTNAMEDCREDENTIAL = 'MockBin';
    private static final String GETBINPATH = '4cb453a6-a23b-42ea-a6ba-9be1c1f17050';

    public class ApiException extends Exception {
    }

    public ApiServiceRecipes() {
        namedCredentialName = DEFAULTNAMEDCREDENTIAL;
    }
    
    public List<ApiServiceRecipesDataModel> getCurrentData() {
        HttpResponse response = get(GETBINPATH);
        
        switch on response.getStatusCode() {
            when 200 {
                try {
                    return ApiServiceRecipesDataModel.parse(response.getBody());
                } catch (System.JSONException jse) {
                    throw new ApiServiceRecipes.ApiException(jse.getMessage());
                }
            }
            when 404 {
                throw new ApiServiceRecipes.ApiException('404 error!');
            }
            when else {
                throw new ApiServiceRecipes.ApiException('Unexpected Response code: ' + response.getStatusCode());
            }
        }
    }
}