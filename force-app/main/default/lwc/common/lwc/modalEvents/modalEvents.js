import { ShowToastEvent } from 'lightning/platformShowToastEvent';
class ModalEvents {
    constructor(context) {
        this.dispatchEvent = context.dispatchEvent.bind(context);
    }

    dispatchClose(options = {}) {
        this.fireEvent('modalclose', options);
    }
    fireEvent(action, options) {
        this.dispatchEvent(new CustomEvent(action, options));
    }
}

const successToast = (message) => 
    new ShowToastEvent({
        title: 'Success',
        message,
        variant: 'success'
    });

const errorToast = (message) => 
    new ShowToastEvent({
        title: 'Error',
        message,
        variant: 'error'
    });

export { ModalEvents, successToast, errorToast };