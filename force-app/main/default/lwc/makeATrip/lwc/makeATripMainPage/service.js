import { callApex } from 'c/baseService';

const CLASS_NAME = 'MakeATripController';

const getTripsData = (parameters) => {
    return callApex({
        className: CLASS_NAME,
        methodName: 'getTripsData',
        parameters
    });
};

export { getTripsData };