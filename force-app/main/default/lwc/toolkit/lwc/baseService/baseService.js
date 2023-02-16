import invoke from '@salesforce/apex/RootProvider.invoke';

const handleResult = (data) => {
    const result = JSON.parse(data);

    if (result.status === 'SUCCESS') {
        return Promise.resolve(JSON.parse(result.resultJson));
    }
    return Promise.reject(result.errorDetails);
};

const callApex = ({ className, methodName, parameters }) => {
    const request = JSON.stringify({
        className,
        methodName,
        parametersJson: JSON.stringify(parameters)
    });

    return invoke({ request }).then(handleResult);
};

export { callApex };
