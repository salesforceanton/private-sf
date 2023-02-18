public inherited sharing class TripSelector {
    public static List<Trip__c> getAllFutureTrips() {
        return [
            SELECT Id, Name, Contact__r.Name, Flight__r.Name, PreferredTripStart__c, Status__c
            FROM Trip__c
            WHERE PreferredTripStart__c <= :Date.today()
        ];
    }
}