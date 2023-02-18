import { LightningElement, track } from 'lwc';
import HEADER_IMAGE_SRC from '@salesforce/resourceUrl/makeATripModarHeaderLogo';

import { ModalEvents } from 'c/modalEvents';
import * as _labels from './labels';

export default class MakeATripCreateFlightModal extends LightningElement {
    _events = new ModalEvents(this);
    labels = _labels;
    headerImageSrc = HEADER_IMAGE_SRC;

    @track isFetching = true;

    handleFormLoad() {
        this.stopSpinner();
    }

    stopSpinner() {
        this.isFetching = false;
    }

    handleClose() {
        this._events.dispatchClose({ bubbles: true, composed: true, cancelable: true });
    }

    handleSaveFlight() {
        this.template.querySelector('lightning-record-edit-form').submit();
    }
}