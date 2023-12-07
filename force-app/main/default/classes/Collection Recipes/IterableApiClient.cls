public with sharing class MockRestClient extends RestClient {
    public HttpResponse get(String url) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody('{"records":["record1","record2"],"totalRecordCount":2}');
        return response;
    }
}

@isTest
private class IterableApiClientTest {
    @isTest
    static void testIterator() {
        IterableApiClient iterableApiClient = new IterableApiClient('Mock Credential');
        IterableApiClient.RecordPageIterator iterator = iterableApiClient.iterator();
        
        // Test hasNext() method
        System.assert(iterator.hasNext());
        
        // Test next() method
        IterableApiClient.RecordPage page = iterator.next();
        System.assertEquals(2, page.totalRecordCount);
        System.assertEquals(0, iterator.currentPageIndex);
        System.assertFalse(iterator.hasNext());
        
        // Test calling next() multiple times
        page = iterator.next();
        System.assertEquals(1, iterator.currentPageIndex);
        System.assertEquals('record1', page.records[0]);
        System.assertEquals('record2', page.records[1]);
        System.assertThrows(NoSuchElementException.class, () -> {
            iterator.next();
        });
    }
}