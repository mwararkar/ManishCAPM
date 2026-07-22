namespace SalesOrderApp.reuse;

//Standard Type
using {Currency} from '@sap/cds/common';

//Custom Types
type Identity    : String(32);
type Phonenumber : String(32);
type Name        : String(64);
type Postalcode  : String(16);
type Email       : String(255);

//Enumerator
type Gender      : String(1) enum {
    Male = 'M';
    Female = 'F';
    Undisclosed = 'U';
}

//Custom Type
type AmountT     : Decimal(10, 2) @(
    Semantics.amount.currencyCode: 'CURRENCY_CODE',
    sap.unit                     : 'CURRENCY_CODE'
);

//Reusable aspects - Group of fields similar like a structure
aspect Amount : {
    GROSS_AMOUNT : AmountT @(title: '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT   : AmountT @(title: '{i18n>NET_AMOUNT}');
    TAX_AMOUNT   : AmountT @(title: '{i18n>TAX_AMOUNT}');
    CURRENCY     : Currency @(title: '{i18n>CURRENCY_CODE}');
}

aspect Address : {
    STREET     : String(64) @(title: '{i18n>STREET}');
    city       : Name @(title: '{i18n>CITY}');
    Postalcode : Postalcode @(title: '{i18n>POSTAL}');
    Country    : String(26) @(title: '{i18n>COUNTRY}');
}
