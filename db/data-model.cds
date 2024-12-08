using {cuid} from '@sap/cds/common';

entity Countries : cuid {
    name: String;
    population: Integer;
}
