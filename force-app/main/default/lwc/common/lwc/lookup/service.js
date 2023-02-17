import { callApex } from 'c/baseService';

const CLASS_NAME = 'LookupController';

const getRecords = (parameters) => {
    return callApex({
        className: CLASS_NAME,
        methodName: 'getRecords',
        parameters
    });
};

export { getRecords };