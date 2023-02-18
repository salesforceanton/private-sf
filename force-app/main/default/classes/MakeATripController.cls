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
}