// TODO: This is a draft cmp in development.
// TODO: Adjust controller methods and beans for this (LookupRequest, LookupRsponse)
import { LightningElement, api, track } from 'lwc';

import { getRecords } from './service';
import * as _labels from './labels';

const DELAY = 350;

export default class Lookup extends LightningElement {
    @api label;
    @api value;
    @api required;
    @api 
    get lookupScope() {
        return this._lookupScope || {};
    }
    set lookupScope(input) {
        this._lookupScope = input;
        this._lookupScope && this.getRecords()
    };

    @track records;
    @track hasError;
    
    get selectedItem() {
        return this.value && this.records.length && this.records.find((e) => e.Id === this.value) || {};;
    }
    
    get selectedItemName() {
        return this.selectedItem.Name || ''; 
    }

    get wrapperConatinerClass() {
        return this.hasError && 'slds-form-element slds-has-error' || 'slds-form-element'
    }

    handleKeyUp(e) {
        const { value } = e.target;
       
        window.clearTimeout(this.timeout);
        if (value) {
            this.timeout = setTimeout(() => this.search(value), DELAY);    
        }       
    }

    getRecords(value) {
        getRecords({ ...this.lookupScope, searchString: value })
            .then((result) => this.handleGetRecords(result))
            .catch((error) => this.handleError(error)) 
    }

    handleGetRecords(result) {
        this.records = result;
    }

    handleError(error) {
        console.error(JSON.stringify(error));
    }

    handleSelect(e){
        const value = e.target.getAttribute('data-id');
        this.dispatchValueChange(value);
    }

    handleRemove() {
        this.dispatchValueChange(null);
    }

    dispatchValueChange(value) {
        this.dispatchEvent(new CustomEvent('select', {
            detail: value
        }))
    }

    handleBlurLookup() {
        this.hasError = !this.value && this.required;
    }
}