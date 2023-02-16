global class InvokeApexResponse {
    private String status;
    private String errorDetails;
    private String resultJson;
    private Object result;

    public InvokeApexResponse() {
        this.status = 'SUCCESS';
    }

    public Boolean isSuccess() {
        return this.status == 'SUCCESS';
    }

    public Object getResult() {
        if (this.result == null && String.isNotBlank(this.resultJson)) {
            this.result = JSON.deserializeUntyped(this.resultJson);
        }

        return this.result;
    }

    public Object getResult(Type type) {
        if (this.result == null && String.isNotBlank(this.resultJson)) {
            this.result = JSON.deserialize(this.resultJson, type);
        }

        return this.result;
    }

    public void setError(Exception e) {
        this.status = 'ERROR';
        this.errorDetails = e.getMessage();
    }

    public void setResult(Object result) {
        this.result = result;
    } 
    
    public String toJson() {
        this.resultJson = JSON.serialize(this.getResult());
        return JSON.serialize(this);
    }
}
