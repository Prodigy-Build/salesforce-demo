public with sharing class CanTheUserPermissions {
    public static Boolean hasPermission() {
        ApiServiceRecipes apiService = new ApiServiceRecipes();
        List<ApiServiceRecipesDataModel> data = apiService.getCurrentData();
        
        String userRole = getUserRole();
        String requiredPermission = getRequiredPermission();
        
        for (ApiServiceRecipesDataModel model : data) {
            if (model.getRole().equalsIgnoreCase(userRole)) {
                if (model.getPermissions().contains(requiredPermission)) {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    private static String getUserRole() {
        // code to get user role here
    }
    
    private static String getRequiredPermission() {
        // code to get required permission here
    }
}