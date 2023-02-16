public class RootProxy {
    public Object invokeApex(InvokeApexRequest request) {
        RootProvider.UiProvider gateway = (RootProvider.UiProvider) this.getRequestType(request).newInstance();
        return gateway.invoke(request);
    }

    private Type getRequestType(InvokeApexRequest request) {
        if (String.isBlank(request.getClassName()))
            throw new RootProxyException('Class name property is required!');
        if (String.isBlank(request.getMethodName()))
            throw new RootProxyException('Method name property is required!');

        Type result = Type.forName(request.getProxyName());

        if (result == null) {
            throw new RootProxyException('Class name is invalid');
        }

        return result;
    }

    public class RootProxyException extends Exception {
    }
}