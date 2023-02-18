global with sharing class RootProvider {
    @AuraEnabled
    global static String invoke(String request) {
        return run((InvokeApexRequest) JSON.deserialize(request, InvokeApexRequest.class)).toJson();
    }

    private static InvokeApexResponse run(InvokeApexRequest request) {
        InvokeApexResponse result = new InvokeApexResponse();
        try {
            RootProxy proxy = new RootProxy();
            result.setResult(proxy.invokeApex(request));
        } catch (Exception e) {
            result.setError(e);
        }
        return result;
    }

    public interface UiProvider {
        Object invoke(InvokeApexRequest request);
    }
}
