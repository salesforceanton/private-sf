public inherited sharing class MakeATripController {
    public static final String ISO_DATE_FORMAT = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';

    public static MakeATripBeans.TripsData getTripsData() {
        List<Trip__c> proceedTrips = new List<Trip__c>();
        List<Trip__c> bookedTrips = new List<Trip__c>();

        for (Trip__c record : TripSelector.getAllFutureTrips()) {
            if (record.Status__c == TripConstants.TripStatus.FLIGHT_SEARCH.name()) {
                proceedTrips.add(record);
            } else {
                bookedTrips.add(record);
            }
        }

        MakeATripBeans.TripsData result = new MakeATripBeans.TripsData();
        result.setProceedTrips(MakeATripBeansMapper.mapTripsToListTripDataRow(proceedTrips));
        result.setBookedTrips(MakeATripBeansMapper.mapTripsToListTripDataRow(bookedTrips));

        return result;
    }

    public static List<MakeATripBeans.FlightsTableRow> getAvailableFlights(String preferredDate) {
        Date requestedDay = Date.valueOf(preferredDate);
        return MakeATripBeansMapper.mapFlightsToListFlightsTableRow(
            FlightSelector.getFlightsInPreferredDay(requestedDay)
        );
    }

    public static Id saveTrip(MakeATripBeans.SaveTripRequest request) {
        Trip__c record = request.getRecord();
        if (record.Flight__c != null) {
            proceedBooking(request);
        }
        upsert record;
        return record.Id;
    }

    private static void proceedBooking(MakeATripBeans.SaveTripRequest request) {
        Trip__c record = request.getRecord();

        // Get available ticket (if no one - throw exception to fail transaction)
        Ticket__c freeTicket = TicketService.getAvailableTicket(record.Flight__c);

        // Make callout to register ticket in external system
        BookTicketsRestService.BookRequest bookRequest = new BookTicketsRestService.BookRequest();
        bookRequest.setContact(request.getClientName());
        bookRequest.setTicketnumber(freeTicket.Name);

        TicketService.bookTicket(bookRequest);

        // If register at external syste is success - proceed on SF side result
        record.Status__c = TripConstants.TripStatus.FLIGHT_BOOKED.name();
        freeTicket.Contact__c = record.Contact__c;

        update freeTicket;
    }
}