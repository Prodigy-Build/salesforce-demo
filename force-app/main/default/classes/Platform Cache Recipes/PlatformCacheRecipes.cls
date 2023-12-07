public with sharing class PlatformCacheRecipesTest {
    
    @IsTest
    static void testStoreValueInSessionCache() {
        String key = 'testKey';
        String toStore = 'testValue';
        Integer ttl = 3600;
        
        Test.startTest();
        PlatformCacheRecipes.storeValueInSessionCache(key, toStore, ttl);
        Test.stopTest();
        
        String cachedValue = PlatformCacheRecipes.getValueFromSessionCache(key);
        System.assertEquals(toStore, cachedValue);
    }
    
    @IsTest
    static void testGetValueFromSessionCache() {
        String key = 'testKey';
        String toStore = 'testValue';
        Integer ttl = 3600;
        
        Test.startTest();
        PlatformCacheRecipes.storeValueInSessionCache(key, toStore, ttl);
        Test.stopTest();
        
        String cachedValue = PlatformCacheRecipes.getValueFromSessionCache(key);
        System.assertEquals(toStore, cachedValue);
    }
    
    @IsTest
    static void testRemoveKeyFromSessionCache() {
        String key = 'testKey';
        String toStore = 'testValue';
        Integer ttl = 3600;
        
        Test.startTest();
        PlatformCacheRecipes.storeValueInSessionCache(key, toStore, ttl);
        Test.stopTest();
        
        Test.startTest();
        PlatformCacheRecipes.removeKeyFromSessionCache(key);
        Test.stopTest();
        
        String cachedValue = PlatformCacheRecipes.getValueFromSessionCache(key);
        System.assertEquals('Cache Miss', cachedValue);
    }
    
    @IsTest
    static void testStoreValueInOrgCache() {
        String key = 'testKey';
        String toStore = 'testValue';
        Integer ttl = 3600;
        
        Test.startTest();
        PlatformCacheRecipes.storeValueInOrgCache(key, toStore, ttl);
        Test.stopTest();
        
        String cachedValue = PlatformCacheRecipes.getValuefromOrgCache(key);
        System.assertEquals(toStore, cachedValue);
    }
    
    @IsTest
    static void testGetValuefromOrgCache() {
        String key = 'testKey';
        String toStore = 'testValue';
        Integer ttl = 3600;
        
        Test.startTest();
        PlatformCacheRecipes.storeValueInOrgCache(key, toStore, ttl);
        Test.stopTest();
        
        String cachedValue = PlatformCacheRecipes.getValuefromOrgCache(key);
        System.assertEquals(toStore, cachedValue);
    }
    
    @IsTest
    static void testRemoveKeyFromOrgCache() {
        String key = 'testKey';
        String toStore = 'testValue';
        Integer ttl = 3600;
        
        Test.startTest();
        PlatformCacheRecipes.storeValueInOrgCache(key, toStore, ttl);
        Test.stopTest();
        
        Test.startTest();
        PlatformCacheRecipes.removeKeyFromOrgCache(key);
        Test.stopTest();
        
        String cachedValue = PlatformCacheRecipes.getValuefromOrgCache(key);
        System.assertEquals('Cache Miss', cachedValue);
    }
}