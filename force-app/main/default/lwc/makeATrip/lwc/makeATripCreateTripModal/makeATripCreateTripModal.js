import { LightningElement, api, track, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import HEADER_IMAGE_SRC from '@salesforce/resourceUrl/makeATripModarHeaderLogo';

import { ModalEvents } from 'c/modalEvents';

import { fligtsColumns } from './constants';
import { getAvailableFlights } from './service';
import * as _labels from './labels';

import CONTACT_FIELD_NAME from '@salesforce/schema/Trip__c.Contact__c';
import FLIGHT_FIELD_NAME from '@salesforce/schema/Trip__c.Flight__c';
import PREFERRED_DATE_FIELD_NAME from '@salesforce/schema/Trip__c.PreferredTripStart__c';
import CLIENT_NAME_FIELD from '@salesforce/schema/Contact.Name'

export default class MakeATripCreateTripModal extends LightningElement {
    @api recordId;

    @track record = {};
    @track flights;
    @track clientId;
    @track isFetching = true;

    @wire(getRecord, {
        recordId: '$clientId',
        fields: [CLIENT_NAME_FIELD]
    })
    client;

    _events = new ModalEvents(this);
    labels = _labels;
    columns = fligtsColumns;
    headerImageSrc = HEADER_IMAGE_SRC;

    connectedCallback() {
        const preferredDate = this.record[PREFERRED_DATE_FIELD_NAME.fieldApiName];
        preferredDate && this.getAvailableFlights(preferredDate);
    }

    get tripName() {
        const preferredDate = this.record[PREFERRED_DATE_FIELD_NAME.fieldApiName] || '';
        return this.clientName && preferredDate &&  `${this.clientName} ${preferredDate}` || '';
    }

    get clientName() {
        return this.client.data && getFieldValue(this.client.data, CLIENT_NAME_FIELD) || '';
    }

    get flightFieldValue() {
        return this.record[FLIGHT_FIELD_NAME.fieldApiName];
    }

    get flightsTableMessage() {
        return !this.flights?.length && this.labels.emptyFlightsTableMessage || '';
    }

    handleFormLoad(e) {
        const { record }= e.detail;
        this.stopSpinner();
        this.applyRecord(record);
    }

    applyRecord(record) {
        const fieldValues = record.fields;
        this.record = Object.keys(fieldValues).reduce((result, fieldName) => {
            result[fieldName] = fieldValues[fieldName].value;
            return result;
        }, {});
    }

    handleFormFieldChange(e) {
        const { value } = e.target;
        const fieldName = e.target.getAttribute('data-field-name');
        this.record = {
            ...this.record,
            [fieldName]: value
        }
        if (fieldName === CONTACT_FIELD_NAME.fieldApiName) {
            this.clientId = value;
        } else if (fieldName === PREFERRED_DATE_FIELD_NAME.fieldApiName) {
            this.getAvailableFlights(value);
        }
    }

    handleRowAction(e) {
        const { action, row } = e.detail;
        switch (action.name) {
            case 'rowSelect':
                this.handleFlightSelect(row.id);
                break;
            default:
        }
    }

    handleFlightSelect(value) {
        this.record[FLIGHT_FIELD_NAME.fieldApiName] = value;
    }

    getAvailableFlights(date) {
        this.isFetching = true;
        getAvailableFlights(date)
            .then((result) => this.handleGetFlights(result))
            .catch((e) => this.handleError(e))
            .finally(() => this.stopSpinner());
    }

    handleGetFlights(result) {
        this.flights = result;
    }

    stopSpinner() {
        this.isFetching = false;
    }

    handleError(e) {
        console.error(e);
    }

    handleClose() {
        this._events.dispatchClose({ bubbles: true, composed: true, cancelable: true });
    }

    handleSaveFlight() {
        this.template.querySelector('lightning-record-edit-form').submit();
    }
}