/**
 * @description An example implementation of Comparator Interface
 * In this example we show how to sort all the accounts by their aggregated billing data in ascending order
 **/

public with sharing class AccountAggregatedBillingDataComparator implements Comparator<Account> {
    public Integer compare(Account a1, Account a2) {
        // Guard against null operands for ‘<’ or ‘>’ operators because
        // they will always return false and produce inconsistent sorting
        Integer result;
        if (a1?.AnnualRevenue == null && a2?.AnnualRevenue == null) {
            result = 0;
        } else if (a1?.AnnualRevenue == null) {
            result = -1;
        } else if (a2?.AnnualRevenue == null) {
            result = 1;
        } else if (a1.AnnualRevenue < a2.AnnualRevenue) {
            result = -1;
        } else if (a1.AnnualRevenue > a2.AnnualRevenue) {
            result = 1;
        } else {
            result = 0;
        }
        return result;
    }
}