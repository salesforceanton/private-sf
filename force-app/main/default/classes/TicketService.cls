/**
 * Class to perfom operations with `Ticket__c` SObject
 */
public inherited sharing class TicketService {
    /**
     * Generate Tikects for new Flight
     * 
     * @param     flights List of `Flight__c` record
     * @exception IllegalArgumentException if argument is null
     */
    public static void generateTicketsForNewFlights(List<Flight__c> flights) {
        if (flights == null && flights.isEmpty()) {
            throw new IllegalArgumentException('[generateTicketsForNewFlight]: Empty param');
        }
        
        List<Ticket__c> tickets = new List<Ticket__c>();
        for (Flight__c flight : flights) {
            tickets.addAll(generateTickets(flight));
        }

        insert tickets;
    }

    private static List<Ticket__c> generateTickets(Flight__c flight) {
        List<Ticket__c> result = new List<Ticket__c>();
        for (Integer i = 1; i <= flight.Capacity__c; i++) {
            result.add(new Ticket__c(
                Name = flight.Name + '-' + i,
                Flight__c = flight.Id
            ));
        }
        
        return result;
    }
}