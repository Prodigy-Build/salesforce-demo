public with sharing class AccountServiceLayer {
    @testVisible
    private static String didExecuteMethod;

    public class ASLException extends Exception {
    }

    public static void justWriteALogStatement(String toLog) {
        AccountServiceLayer.didExecuteMethod = toLog;
        System.debug(LoggingLevel.INFO, 'Account Id = and log statement = ' + toLog);
    }

    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static void changeShippingStreet(List<Account> accounts, System.AccessLevel accessLevel) {
        List<Account> updated = new List<Account>();
        for (Account account : accounts) {
            Account uAcct = account.clone(true);
            uAcct.ShippingStreet = '229b Baker st.';
            updated.add(uAcct);
        }
        Database.update(updated, accessLevel);
    }

    public static List<Account> incrementCounterInDescription(List<Account> incomingAccounts, Boolean save) {
        for (Account ia : incomingAccounts) {
            Integer counter = 0;
            try {
                if (ia.Description != null) {
                    counter = Integer.valueOf(ia.Description);
                }
            } catch (System.TypeException te) {
                System.debug(LoggingLevel.INFO, 'failed safely to 0 during init');
            }
            counter++;
            ia.Description = String.valueOf(counter);
        }
        if (save) {
            safelySave(incomingAccounts);
        }
        return incomingAccounts;
    }

    @testVisible
    private static void safelySave(List<Account> accounts) {
        try {
            System.SObjectAccessDecision decision = Security.stripInaccessible(AccessType.UPDATABLE, accounts);
            update as user decision.getRecords();
        } catch (DmlException dmle) {
            System.debug(LoggingLevel.INFO, 'Hey, a DML error occurred while updating.');
            throw new ASLException(dmle.getMessage());
        } catch (System.SecurityException se) {
            throw new ASLException(se.getMessage());
        } catch (System.NoAccessException nae) {
            throw new ASLException(nae.getMessage());
        }
    }
}