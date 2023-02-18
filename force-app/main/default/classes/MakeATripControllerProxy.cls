public with sharing class MakeATripControllerProxy implements RootProvider.UiProvider {
    @TestVisible
    private static final String CONTROLLER_NAME = MakeATripController.class.getName();

    public Object invoke(InvokeApexRequest request) {
        try {
            switch on request.getMethodName() {
                when 'getTripsData' {
                    return MakeATripController.getTripsData();
                }
                when 'getAvailableFlights' {
                    return MakeATripController.getAvailableFlights((String) request.getParameters(String.class));
                }
                when else {
                    throw new MakeATripControllerProxyException('[MakeATripControllerProxy]: Method doen`t exist');
                }
            }
        } catch (System.JSONException e) {
            throw new MakeATripControllerProxyException(e.getMessage());
        }
    }

    public class MakeATripControllerProxyException extends Exception {
    }
}
