public inherited sharing class MakeATripBeansMapper {
    public static List<MakeATripBeans.FlightsTableRow> mapFlightsToListFlightsTableRow(List<Flight__c> source) {
        List<MakeATripBeans.FlightsTableRow> target = new List<MakeATripBeans.FlightsTableRow>();
        for (Flight__c sourceItem : source) {
            target.add(mapFlightToFlightsTableRow(sourceItem));
        }
        return target;
    }

    public static List<MakeATripBeans.TripDataRow> mapTripsToListTripDataRow(List<Trip__c> source) {
        List<MakeATripBeans.TripDataRow> target = new List<MakeATripBeans.TripDataRow>();
        for (Trip__c sourceItem : source) {
            target.add(mapTripToTripDataRow(sourceItem));
        }
        return target;
    }

    public static MakeATripBeans.TripDataRow mapTripToTripDataRow(Trip__c source) {
        MakeATripBeans.TripDataRow target = new MakeATripBeans.TripDataRow();
        mapTo(source, target);
        return target;
    }

    public static MakeATripBeans.FlightsTableRow mapFlightToFlightsTableRow(Flight__c source) {
        MakeATripBeans.FlightsTableRow target = new MakeATripBeans.FlightsTableRow();
        mapTo(source, target);
        return target;
    }

    private static void mapTo(Trip__c source, MakeATripBeans.TripDataRow target) {
        String clientName = String.isBlank(source.Contact__r?.Name) ? '' : source.Contact__r.Name;
        target.setId(source.Id);
        target.setClientName(clientName);
        target.setFlight(source.Flight__r.Name);
        target.setName(source.Name);
        target.setLink(String.format('/{0}', new List<String>{ source.Id }));
        target.setPreferredTripStart(source.PreferredTripStart__c);
    }

    private static void mapTo(Flight__c source, MakeATripBeans.FlightsTableRow target) {
        target.setId(source.Id);
        target.setName(source.Name);
        target.setLink(String.format('/{0}', new List<String>{ source.Id }));
        target.setCapacity(Integer.valueOf(source.Capacity__c));
        target.setStart(source.Start__c);
    }
}