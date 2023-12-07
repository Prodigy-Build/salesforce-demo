// Unit tests for iterateOnAccountList method
@isTest
static void testIterateOnAccountList() {
    // Create test accounts with different number of employees
    Account acct1 = new Account(Name = 'Acme', NumberOfEmployees = 100);
    Account acct2 = new Account(Name = 'ABC Company', NumberOfEmployees = 200);
    Account acct3 = new Account(Name = 'XYZ Corp', NumberOfEmployees = 300);
    List<Account> accounts = new List<Account>{acct1, acct2, acct3};

    Integer totalEmployees = IterationRecipes.iterateOnAccountList(accounts);
    // Verify the total count of employees for the accounts
    System.assertEquals(600, totalEmployees);
}

// Unit tests for iterableApiClientRecipe method
@isTest
static void testIterableApiClientRecipe() {
    // Create a mock IterableApiClient
    IterableApiClientMock mockClient = new IterableApiClientMock('myNamedCredential');
    IterableApiClient.RecordPage page1 = new IterableApiClient.RecordPage();
    page1.setRecords(new List<String>{'record1', 'record2', 'record3'});
    IterableApiClient.RecordPage page2 = new IterableApiClient.RecordPage();
    page2.setRecords(new List<String>{'record4', 'record5', 'record6'});
    mockClient.setMockPages(new List<IterableApiClient.RecordPage>{page1, page2});

    Test.startTest();
    List<String> records = IterationRecipes.iterableApiClientRecipe();
    Test.stopTest();

    // Verify the records retrieved
    System.assertEquals(6, records.size());
    System.assertEquals('record1', records[0]);
    System.assertEquals('record6', records[5]);
}

// Mock class for IterableApiClient
public class IterableApiClientMock implements Iterator<IterableApiClient.RecordPage> {
    private String namedCredential;
    private List<IterableApiClient.RecordPage> mockPages;
    private Integer currentPageIndex;

    public IterableApiClientMock(String namedCredential) {
        this.namedCredential = namedCredential;
        this.currentPageIndex = 0;
    }

    public void setMockPages(List<IterableApiClient.RecordPage> mockPages) {
        this.mockPages = mockPages;
    }

    public Boolean hasNext() {
        return currentPageIndex < mockPages.size();
    }

    public IterableApiClient.RecordPage next() {
        if (currentPageIndex >= mockPages.size()) {
            return null;
        }
        Integer nextPageIndex = currentPageIndex + 1;
        currentPageIndex = nextPageIndex;
        return mockPages[currentPageIndex - 1];
    }
}