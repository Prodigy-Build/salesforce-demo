public with sharing class DMLRecipes {
    
    public class CustomDMLException extends Exception {
    }
    
    public static Account insertAccountViaInsertKeywordInSystemMode(
        String name
    ) {
        Account acct = new Account();
        acct.Name = name;
        try {
            insert as system acct;
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return acct;
    }
    
    public static Account insertAccountViaInsertKeywordInUserMode(String name) {
        Account acct = new Account();
        acct.Name = name;
        try {
            insert as user acct;
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return acct;
    }
    
    public static List<Account> insertAccountsViaDatabaseMethod(
        List<String> names,
        Boolean allOrNothing,
        System.AccessLevel accessLevel
    ) {
        List<Account> accounts = new List<Account>();
        for (String name : names) {
            accounts.add(new Account(Name = name));
        }
        try {
            Database.insert(accounts, allOrNothing, accessLevel);
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accounts;
    }
    
    public static Account upsertAccountViaUpsertKeywordInSystemMode(
        Account acct
    ) {
        try {
            upsert as system acct;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw DMLe;
        }
        return acct;
    }
    
    public static Account upsertAccountViaUpsertKeywordInUserMode(
        Account acct
    ) {
        try {
            upsert as user acct;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw DMLe;
        }
        return acct;
    }
    
    public static Database.UpsertResult upsertAccountViaDatabaseMethod(
        Account acct,
        Boolean allOrNothing,
        System.AccessLevel accessLevel
    ) {
        try {
            Database.UpsertResult results;
            results = Database.upsert(acct, allOrNothing, accessLevel);
            return results;
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
    }
    
    public static List<Account> updateAcccountViaKeywordInSystemMode(
        List<Account> accts
    ) {
        for (Account acct : accts) {
            acct.Name += ' Updated via Keyword';
        }
        try {
            update as system accts;
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }
    
    public static List<Account> updateAcccountViaKeywordInUserMode(
        List<Account> accts
    ) {
        for (Account acct : accts) {
            acct.Name += ' Updated via Keyword';
        }
        try {
            update as user accts;
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }
    
    public static List<Account> updateAccountViaDatabaseMethod(
        List<Account> accts,
        System.AccessLevel accessLevel
    ) {
        for (Account acct : accts) {
            acct.Name += ' Updated via Keyword';
        }
        try {
            Database.update(accts, accessLevel);
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw new CustomDMLException('Failed');
        }
        return accts;
    }
    
    public static void deleteAccountViaKeywordInSystemMode(
        List<Account> accts
    ) {
        try {
            delete as system accts;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw new CustomDMLException('Failed');
        }
    }
    
    public static void deleteAccountViaKeywordInUserMode(List<Account> accts) {
        try {
            delete as user accts;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw new CustomDMLException('Failed');
        }
    }
    
    public static void deleteAccountViaDatabaseMethod(
        List<Account> accts,
        System.AccessLevel accessLevel
    ) {
        try {
            Database.delete(accts, accessLevel);
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
    }
    
    public static List<Account> undeleteAccountViaKeywordInSystemMode(
        List<Account> accts
    ) {
        try {
            undelete as system accts;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw new CustomDMLException('Failed');
        }
        return accts;
    }
    
    public static List<Account> undeleteAccountViaKeywordInUserMode(
        List<Account> accts
    ) {
        try {
            undelete as user accts;
        } catch (DmlException DMLe) {
            System.debug(LoggingLevel.INFO, DMLe.getMessage());
            throw new CustomDMLException('Failed');
        }
        return accts;
    }
    
    public static List<Account> undeleteAccountViaDatabaseMethod(
        List<Account> accts,
        System.AccessLevel accessLevel
    ) {
        try {
            Database.undelete(accts, accessLevel);
        } catch (DmlException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }
}