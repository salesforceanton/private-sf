import { LightningElement } from 'lwc';
import HEADER_IMAGE_SRC from '@salesforce/resourceUrl/makeATripLogo';

import * as _labels from './labels';

export default class MakeATripMainPage extends LightningElement {
    headerImageSrc = HEADER_IMAGE_SRC;
    labels = _labels;


}