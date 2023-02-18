public class MakeATripBeans {
    public class TripsData {
        private List<TripDataRow> proceedTrips;
        private List<TripDataRow> bookedTrips;

        public List<TripDataRow> getProceedTrips() {
            return this.proceedTrips;
        }
        public void setProceedTrips(List<TripDataRow> input) {
            this.proceedTrips = input;
        }
        public List<TripDataRow> getBookedTrips() {
            return this.bookedTrips;
        }
        public void setBookedTrips(List<TripDataRow> input) {
            this.bookedTrips = input;
        }
    }

    public class TripDataRow {
        private String id;
        private String name;
        private String link;
        private String clientName;
        private String flight;
        private Date preferredTripStart;

        public String getId() {
            return this.id;
        }
        public void setId(String input) {
            this.id = input;
        }
        public String getName() {
            return this.name;
        }
        public void setName(String input) {
            this.name = input;
        }
        public String getLink() {
            return this.link;
        }
        public void setLink(String input) {
            this.link = input;
        }
        public String getClientName() {
            return this.clientName;
        }
        public void setClientName(String input) {
            this.clientName = input;
        }
        public String getFlight() {
            return this.flight;
        }
        public void setFlight(String input) {
            this.flight = input;
        }
        public Date getPreferredTripStart() {
            return this.preferredTripStart;
        }
        public void setPreferredTripStart(Date input) {
            this.preferredTripStart = input;
        }
    }

    public class FlightsTableRow {
        private String id;
        private String link;
        private String name;
        private Integer capacity;
        private Datetime start;

        public String getId() {
            return this.id;
        }
        public void setId(String input) {
            this.id = input;
        }
        public String getLink() {
            return this.link;
        }
        public void setLink(String input) {
            this.link = input;
        }
        public String getName() {
            return this.name;
        }
        public void setName(String input) {
            this.name = input;
        }
        public Integer getCapacity() {
            return this.capacity;
        }
        public void setCapacity(Integer input) {
            this.capacity = input;
        }
        public Datetime getStart() {
            return this.start;
        }
        public void setStart(Datetime input) {
            this.start = input;
        }
    }

    public class SaveTripRequest {
        private Trip__c record;
        private String clientName;

        public Trip__c getRecord() {
            return this.record;
        }
        public void setRecord(Trip__c input) {
            this.record = input;
        }
        public String getClientName() {
            return this.clientName;
        }
        public void setClientName(String input) {
            this.clientName = input;
        }
    }
}