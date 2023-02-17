import { LightningElement, api } from 'lwc';
import { ModalEvents } from 'c/modalEvents';

import * as _labels from './labels';

export default class Modal extends LightningElement {
    @api hideCloseButton = false;
    @api headerText;
    @api size;
    @api hideBackdrop;

    labels = _labels;
    _events = new ModalEvents(this);

    get modalStyle() {
        return `slds-modal slds-fade-in-open modal_${this.size}`;
    }

    handleClose() {
        this._events.dispatchClose({ bubbles: true, composed: true, cancelable: true });
    }
}