public virtual with sharing class BaseRestService {
    @TestVisible
    protected String endpoint = '';
    @TestVisible
    protected HttpRequest request;
    @TestVisible
    private HttpResponse response;
    @TestVisible
    protected List<Param> parameters;

    public enum Method {
        GET,
        POST,
        PUT,
        PATCH,
        HEAD,
        TRACE,
        DELETE_METHOD
    }

    @TestVisible
    protected final Integer MAX_TIMEOUT = 2 * 60 * 1000;
    @TestVisible
    protected final String AUTHORIZATION_HEADER = 'Authorization';
    @TestVisible
    protected final String AUTHORIZATION_BASIC_TYPE = 'Basic';
    @TestVisible
    protected final String AUTHORIZATION_BEARER_TYPE = 'Bearer';
    @TestVisible
    protected final String CONTENT_TYPE_HEADER = 'Content-Type';
    @TestVisible
    protected final String ACCEPT_HEADER = 'Accept';
    @TestVisible
    protected final String JSON_CONTENT_TYPE = 'application/json';

    @TestVisible
    protected BaseRestService() {
        this.request = new HttpRequest();
        this.request.setTimeout(MAX_TIMEOUT);
        this.parameters = new List<Param>();
    }

    @TestVisible
    protected void addParameter(String key, Object value) {
        this.parameters.add(new Param(key, String.valueOf(value)));
    }

    @TestVisible
    protected void addParameters(Map<String, Object> params) {
        for (String key : params.keySet()) {
            this.addParameter(key, params.get(key));
        }
    }

    @TestVisible
    protected String getEndpoint() {
        return this.endpoint + (this.parameters.isEmpty() ? '' : '?' + this.getQuery());
    }

    @TestVisible
    protected void setMethod(Method method) {
        this.request.setMethod(method.name().substringBefore('_'));
    }

    public void send() {
        try {
            Http http = new Http();
            this.response = http.send(this.request);
        } catch (Exception e) {
            System.debug(String.valueOf(this).split(':')[0] + e.getMessage() + '\n' + e.getStackTraceString());
        }
    }

    public String getResponseStatus() {
        if (this.response == null) {
            return null;
        }
        return this.response.getStatus();
    }

    public Integer getResponseStatusCode() {
        if (this.response == null) {
            return null;
        }
        return this.response.getStatusCode();
    }

    public String getResponseBody() {
        if (this.response == null) {
            return null;
        }
        return this.response.getBody();
    }

    public virtual Object getResponseBody(Type returnType) {
        String body = this.getResponseBody();
        if (
            this.response.getHeader(CONTENT_TYPE_HEADER) != null &&
            this.response.getHeader(CONTENT_TYPE_HEADER).containsIgnoreCase(JSON_CONTENT_TYPE)
        ) {
            JsonParser parser = JSON.createParser(body);
            parser.nextToken();
            return parser.readValueAs(returnType);
        }
        return body;
    }

    public Blob getResponseBodyAsBlob() {
        if (this.response == null) {
            return null;
        }
        return this.response.getBodyAsBlob();
    }

    public class Param {
        private String name;
        private String value;

        public Param(String name, String value) {
            this.name = name;
            this.value = value;
        }

        public override String toString() {
            return EncodingUtil.urlEncode(name, 'UTF-8') + '=' + EncodingUtil.urlEncode(value, 'UTF-8');
        }
    }

    protected String getQuery() {
        List<String> result = new List<String>();
        for (Param p : this.parameters) {
            result.add(p.toString());
        }

        return String.join(result, '&');
    }
}