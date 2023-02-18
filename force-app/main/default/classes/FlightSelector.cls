public inherited sharing class FlightSelector {
    public static List<Flight__c> getFlightsInPreferredDay(Date preferredDay) {
        return [
            SELECT Id, Name, Capacity__c, Start__c
            FROM Flight__c
            WHERE StartDay__c = :preferredDay
        ];
    }
}