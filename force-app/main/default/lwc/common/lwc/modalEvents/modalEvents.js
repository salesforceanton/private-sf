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

export { ModalEvents };