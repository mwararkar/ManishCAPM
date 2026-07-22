namespace SalesOrderApp.db;
using {
  Currency
} from '@sap/cds/common';

using {SalesOrderApp.reuse as reuse} from './reuse';

context masterdata {
  entity BusinessPartners {
        key NODE_KEY     : reuse.Identity @(title: '{i18n>NODE_KEY}');
            BP_ROLE      : String(2) @(title: '{i18n>BP_ROLE}');
            EMAIL        : reuse.Email @(title: '{i18n>EMAIL}');
            MOBILE       : reuse.Phonenumber @(title: '{i18n>MOBILE}');
            FAX          : String(32) @(title: '{i18n>FAX}');
            WEB          : String(255) @(title: '{i18n>WEB}');
            BP_ID        : reuse.Identity @(title: '{i18n>BP_ID}');
            COMPANY_NAME : reuse.Name @(title: '{i18n>COMPANY_NAME}');
            // Foreign Key - Business Partners
            ADDRESS      : Association to Addresses;
    }

  entity Addresses : reuse.Address {
        key NODE_KEY     : reuse.Identity @(title: '{i18n>NODE_KEY}');
            ADDRESS_TYPE : String(44) @(title: '{i18n>ADDRESS_TYPE}');
            VAL_START    : Date @(title: '{i18n>VAL_START}');
            VAL_END      : Date @(title: '{i18n>VAL_END}');
            LATITUDE     : Decimal @(title: '{i18n>LATITUDE}');
            LONGITUDE    : Decimal @(title: '{i18n>LONGITUDE}');
            // Unamanged Association between Addresses and Business Partners
            // Foreign Key - Address
            BP           : Association to one BusinessPartners
                               on BP.ADDRESS = $self;
    }

  entity Products {
        key NODE_KEY       : reuse.Identity @(title: '{i18n>NODE_KEY}');
            PRODUCT_ID     : String(30) @(title: '{i18n>PRODUCT_ID}');
            TYPE_CODE      : String(2) @(title: '{i18n>TYPE_CODE}');
            CATEGORY       : String(32) @(title: '{i18n>CATEGORY}');
            DESCRIPTION    : String(255) @(title: '{i18n>DESCRIPTION}');
            TAX_TARIF_CODE : Integer @(title: '{i18n>TAX_TARIF_CODE}');
            MEASURE_UNIT   : String(2) @(title: '{i18n>MEASURE_UNIT}');
            WEIGHT_MEASURE : Decimal(5, 2) @(title: '{i18n>WEIGHT_MEASURE}');
            WEIGHT_UNIT    : String(2) @(title: '{i18n>WEIGHT_UNIT}');
            CURRENCY_CODE  : String(4) @(title: '{i18n>CURRENCY_CODE}');
            PRICE          : Decimal(15, 2) @(title: '{i18n>PRICE}');
            WIDTH          : Decimal(5, 2) @(title: '{i18n>WIDTH}');
            DEPTH          : Decimal(5, 2) @(title: '{i18n>DEPTH}');
            HEIGHT         : Decimal(5, 2) @(title: '{i18n>HEIGHT}');
            DIM_UNIT       : String(2) @(title: '{i18n>DIM_UNIT}');
            // Managed Association between Products and Business Partners
            SUPPLIER       : Association to one BusinessPartners;
    }

  entity Employees {
        key ID            : UUID;
            NAMEFIRST     : reuse.Name ;
            NAMELAST      : reuse.Name ;
            NAMEINITIAL   : reuse.Name ;
            NAMEMIDDLE    : reuse.Name ;
            GENDER        : reuse.Gender;
            LANGUAGE      : String(10) ;
            PHONE         : reuse.Phonenumber;
            EMAIL         : reuse.Email ;
            EMPLOYEEID    : Integer ;
            LOGINNAME     : reuse.Name ;
            CURRENCY      : Currency ;
            SALARY        : reuse.AmountT ;
            ACCOUNTNUMBER : String(16) ;
            BANKID        : String(16) ;
            BANKNAME      : String(255);
    }
}

context transaction {
  entity SalesOrders : reuse.Amount {
        key NODE_KEY         : reuse.Identity @(title: '{i18n>NODE_KEY}');
            SO_ID            : String(40) @(title: '{i18n>SO_ID}');
            PARTNER          : Association to one masterdata.BusinessPartners;
            LIFECYCLE_STATUS : String(2) @(title: '{i18n>LIFECYCLE_STATUS}');
            OVERALL_STATUS   : String(2) @(title: '{i18n>OVERALL_STATUS}');
            // Unmanaged Association betwen Sales Orders and Sales Items
            Items            : Association to many SalesItems
                                   on Items.PARENT = $self;
    }

  entity SalesItems : reuse.Amount {
        key NODE_KEY     : reuse.Identity @(title: '{i18n>NODE_KEY}');
            PO_ITEMS_POS : Integer @(title: '{i18n>PO_ITEMS_POS}');
            PRODUCT      : Association to one masterdata.Products;
            PARENT       : Association to one SalesOrders;
    }
}


