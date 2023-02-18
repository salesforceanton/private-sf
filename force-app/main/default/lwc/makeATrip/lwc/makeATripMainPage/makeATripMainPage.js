import { LightningElement, track } from 'lwc';

import HEADER_IMAGE_SRC from '@salesforce/resourceUrl/makeATripLogo';
import SUCCESS_MARK from '@salesforce/resourceUrl/successMark';
import IN_PROCESS_MARK from '@salesforce/resourceUrl/questionMark';
import BACKGROUND_URL from '@salesforce/resourceUrl/makeATripBackground';

import * as _labels from './labels';
import { getTripsData } from './service';
import { proceedColumns, bookedColumns } from './constants';

export default class MakeATripMainPage extends LightningElement {
    @track showCreateFlightModal;
    @track showCreateTripModal;
    @track proceedTripId;

    @track proceedTrips = [];
    @track bookedTrips = [];
    @track isFetching;

    headerImageSrc = HEADER_IMAGE_SRC;
    bookedTableHeaderImageSrc = SUCCESS_MARK;
    inProcessTableHeaderImageSrc = IN_PROCESS_MARK;
    labels = _labels;
    proceedColumns = proceedColumns;
    bookedColumns = bookedColumns;

    connectedCallback() {
        this.getTripsData();
    }

    get backgroundStyle() {
        return `
            background-image:url(${BACKGROUND_URL}); 
            background-size: cover; 
            opacity: 0.8;
            height: 70vh; 
            background-position: center; 
            background-repeat: no-repeat;`;
    }

    getTripsData() {
        this.isFetching = true;
        getTripsData()
            .then((result) => this.handleGetTripsData(result))
            .catch((e) => this.handleError(e))
            .finally(() => this.stopSpinner());
    }

    handleRowAction(e) {
        const { action, row } = e.detail;
        switch (action.name) {
            case 'rowEdit':
                this.proceedTripId = row.id;
                this.handleOpenTripModal();
                break;
            default:
        }
    }

    handleGetTripsData(result) {
        const { proceedTrips, bookedTrips } = result;
        this.proceedTrips = proceedTrips;
        this.bookedTrips = bookedTrips;
    }

    stopSpinner() {
        this.isFetching = false;
    }


    handleError(e) {
        console.error(JSON.stringify(e));
        this.dispatchEvent(errorToast(e));
    }

    handleNewFlight() {
        this.showCreateFlightModal = true;
    }

    handleCloseCreateFlightModal() {
        this.showCreateFlightModal = false;
    }

    handleOpenTripModal() {
        this.showCreateTripModal = true;
    }

    handleCloseCreateTripModal() {
        this.showCreateTripModal = false;
        this.proceedTripId = null;
        this.getTripsData();
    }
}