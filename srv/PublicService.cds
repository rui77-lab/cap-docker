using {
    publicOdata.Airlines,
    publicOdata.Manager
} from './external/publicOdata';

@path: 'public-odata'
service PublicOdataService {

    entity SAirlines as projection on Airlines;
    entity SManager  as projection on Manager;
}

annotate PublicOdataService with @(requires: 'authenticated-user');
