using {Countries as mCountries} from '../db/data-model';

@path: 'hello'
service HelloService {

    function hello() returns String;
    entity Countries as select from mCountries;
}

annotate HelloService with @(requires: 'authenticated-user');