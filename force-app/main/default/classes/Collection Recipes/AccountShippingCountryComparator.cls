/**
 * @description An example implementation of Comparator Interface
 * In this example we show how to sort all the accounts by their country names in alphabetical order
 **/

public with sharing class AccountShippingCountryComparator implements Comparator<Account> {
    /**
     * @description This exception is for throwing a custom exception to
     */
    public class ASCComparatorException extends Exception {
    }

    private String sortOrder;

    private static final Set<String> VALIDSORTORDER = new Set<String>{
        'ascending',
        'descending'
    };

    /**
     * @description No param constructor. Assigns sort order as ascending by default
     */
    public AccountShippingCountryComparator() {
        this.sortOrder = 'ascending'; // use ascending by default
    }

    /**
     * @description    Constructor accepting sort order as ascending/descending. Use
     * this constructor to *control* the sort order.
     * @param sortOrder
     */
    public AccountShippingCountryComparator(String sortOrder) {
        if (!VALIDSORTORDER.contains(sortOrder)) {
            throw new ASCComparatorException('Invalid sort order provided');
        }
        this.sortOrder = sortOrder;
    }

    public Integer compare(Account a1, Account a2) {
        if (a1?.ShippingCountry == null && a2?.ShippingCountry == null) {
            return 0;
        } else if (a1?.ShippingCountry == null) {
            return this.sortOrder == 'descending' ? 1 : -1;
        } else if (a2?.ShippingCountry == null) {
            return this.sortOrder == 'descending' ? -1 : 1;
        }
        return this.sortOrder == 'descending'
            ? a2.ShippingCountry.compareTo(a1.ShippingCountry)
            : a1.ShippingCountry.compareTo(a2.ShippingCountry);
    }
}

// Unit tests
@isTest
public class AccountShippingCountryComparatorTest {
    @isTest
    static void testCompare_BothCountriesNull_ReturnsZero() {
        AccountShippingCountryComparator comparator = new AccountShippingCountryComparator();
        Account a1 = new Account();
        Account a2 = new Account();
        Integer result = comparator.compare(a1, a2);
        System.assertEquals(0, result);
    }

    @isTest
    static void testCompare_A1CountryNullAndSortOrderAscending_ReturnsNegativeOne() {
        AccountShippingCountryComparator comparator = new AccountShippingCountryComparator('ascending');
        Account a1 = new Account();
        Account a2 = new Account(ShippingCountry = 'USA');
        Integer result = comparator.compare(a1, a2);
        System.assertEquals(-1, result);
    }

    @isTest
    static void testCompare_A2CountryNullAndSortOrderAscending_ReturnsOne() {
        AccountShippingCountryComparator comparator = new AccountShippingCountryComparator('ascending');
        Account a1 = new Account(ShippingCountry = 'USA');
        Account a2 = new Account();
        Integer result = comparator.compare(a1, a2);
        System.assertEquals(1, result);
    }

    @isTest
    static void testCompare_SortOrderDescending_ReturnsCorrectComparison() {
        AccountShippingCountryComparator comparator = new AccountShippingCountryComparator('descending');
        Account a1 = new Account(ShippingCountry = 'Canada');
        Account a2 = new Account(ShippingCountry = 'USA');
        Integer result = comparator.compare(a1, a2);
        System.assertEquals(1, result);
    }

    @isTest
    static void testCompare_SortOrderAscending_ReturnsCorrectComparison() {
        AccountShippingCountryComparator comparator = new AccountShippingCountryComparator('ascending');
        Account a1 = new Account(ShippingCountry = 'USA');
        Account a2 = new Account(ShippingCountry = 'Canada');
        Integer result = comparator.compare(a1, a2);
        System.assertEquals(-1, result);
    }

    @isTest
    static void testCompare_A1CountryEqualA2Country_ReturnsZero() {
        AccountShippingCountryComparator comparator = new AccountShippingCountryComparator('ascending');
        Account a1 = new Account(ShippingCountry = 'USA');
        Account a2 = new Account(ShippingCountry = 'USA');
        Integer result = comparator.compare(a1, a2);
        System.assertEquals(0, result);
    }

    @isTest
    static void testConstructor_InvalidSortOrder_ThrowsException() {
        try {
            AccountShippingCountryComparator comparator = new AccountShippingCountryComparator('invalid');
            System.assert(false, 'Expected exception not thrown');
        } catch (AccountShippingCountryComparator.ASCComparatorException e) {
            System.assertEquals('Invalid sort order provided', e.getMessage());
        }
    }
}