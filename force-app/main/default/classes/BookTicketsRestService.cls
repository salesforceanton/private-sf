public with sharing class BookTicketsRestService extends BaseRestService {
    private static final String BOOKING_ENDPOINT = 'https://private-1ce70-testassign.apiary-mock.com/ticket';

    public BookTicketsRestService() {
        super();
        this.endpoint = BOOKING_ENDPOINT;
        this.request.setHeader(CONTENT_TYPE_HEADER, JSON_CONTENT_TYPE);
    }

    public Boolean bookTicket(BookTicketsRestService.BookRequest request) {
        this.request.setEndpoint(this.getEndpoint());
        this.request.setBody(JSON.serialize(request));
        this.setMethod(Method.POST);
        this.send();

        return this.checkResponseStatus();
    }

    private Boolean checkResponseStatus() {
        switch on this.getResponseStatusCode() {
            when 200, 201 {
                return true;
            }
            when 400 {
                throw new BookTicketsRestServiceException(Label.INVALID_INPUT);
            }
            when 404 {
                throw new BookTicketsRestServiceException(Label.NOT_FOUND_DATA);
            }
            when else {
                throw new BookTicketsRestServiceException(Label.INTERNAL_SERVER_ERROR);
            }
        }
    }

    public class BookRequest {
        private String ticketnumber;
        private String contact;

        public String getTicketnumber() {
            return this.ticketnumber;
        }
        public void setTicketnumber(String input) {
            this.ticketnumber = input;
        }
        public String getContact() {
            return this.contact;
        }
        public void setContact(String input) {
            this.contact = input;
        }
    }


    public class BookTicketsRestServiceException extends Exception {
    }
}