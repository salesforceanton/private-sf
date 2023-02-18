public inherited sharing class TicketSelector {    
    public static List<Ticket__c> getAvailableTickets(Id flightId) {
        return [
            SELECT Id, Contact__c, Name
            FROM Ticket__c
            WHERE Flight__c = :flightId
            AND Contact__c = NULL
        ];
    }
}