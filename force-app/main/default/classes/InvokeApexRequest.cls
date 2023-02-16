global class InvokeApexRequest {
    private String methodName;
    private String className;
    private String parametersJson;
    private Object parameters;

    global InvokeApexRequest() {
    }

    global InvokeApexRequest setMethodName(String value) {
        this.methodName = value;
        return this;
    }

    global String getMethodName() {
        return this.methodName;
    }

    global InvokeApexRequest setClassName(String value) {
        this.className = value;
        return this;
    }

    global String getProxyName() {
        return this.className + 'Proxy';
    }

    global String getClassName() {
        return this.className;
    }

    global InvokeApexRequest setParameters(Object value) {
        if (value != null) {
            this.parameters = value;
        }
        return this;
    }

    global Object getParameters(Type parametersType) {
        if (String.isNotBlank(this.parametersJson)) {
            this.parameters = JSON.deserialize(this.parametersJson, parametersType);
        }
        return this.parameters;
    }

    public String getParametersJson() {
        return this.parametersJson;
    }
}