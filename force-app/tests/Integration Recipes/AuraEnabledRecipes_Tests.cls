@isTest
private class AuraEnabledRecipes_Tests {
    @isTest
    static void testUpdateAccountNamePositive() {
        Account acct = (Account) TestUtils.createSObject(
            new Account(Name = 'Original Name')
        );

        Test.startTest();
        AuraEnabledRecipes.updateAccountName(acct.Id, 'New Name');
        Test.stopTest();

        Account updatedAcct = [SELECT Name FROM Account WHERE Id = :acct.Id];
        System.assertEquals('New Name', updatedAcct.Name);
    }

    @isTest
    static void testUpdateAccountNameNegativeInvalidName() {
        Account acct = (Account) TestUtils.createSObject(
            new Account(Name = 'Original')
        );
        Test.startTest();
        try {
            AuraEnabledRecipes.updateAccountName(acct.Id, '');
            System.assertFail('Expected AuraHandledException');
        } catch (AuraHandledException ahe) {
            System.assert(ahe.getMessage().containsIgnoreCase('Script-thrown exception'));
        }
        Test.stopTest();
    }

    @isTest
    static void testUpdateAccountNameNegativeMinAccessProfile() {
        Account acct = (Account) TestUtils.createSObject(
            new Account(Name = 'Original Name')
        );
        User u = TestUtils.createMinAccessUser();
        Test.startTest();
        System.runAs(u) {
            try {
                AuraEnabledRecipes.updateAccountName(acct.Id, 'newValue');
                System.assertFail('Expected AuraHandledException');
            } catch (QueryException qe) {
                System.assert(qe.getMessage().containsIgnoreCase('sObject type \'account\' is not supported'));
            }
        }
        Test.stopTest();
    }

    @isTest
    static void testGetFieldValue() {
        Test.startTest();
        System.assert(AuraEnabledRecipes.getFieldValue().equalsIgnoreCase('hello world'));
        Test.stopTest();
    }
}