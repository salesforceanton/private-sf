import { callApex } from 'c/baseService';

const CLASS_NAME = 'MakeATripController';

const getAvailableFlights = (parameters) => {
    return callApex({
        className: CLASS_NAME,
        methodName: 'getAvailableFlights',
        parameters
    });
};

export { getAvailableFlights };