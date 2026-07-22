using {SalesOrderApp.db as db} from '../db/schema';

using {SalesOrderApp.reuse as reuse} from '../db/reuse';

//using { Currency } from '@sap/cds/common';


service SalesOrderAppServices {

    entity BPService         as projection on db.masterdata.BusinessPartners;

    @readonly
    entity AddService        as projection on db.masterdata.Addresses;

    @insertonly
    entity ProductService    as projection on db.masterdata.Products;

    @Capabilities: {
        InsertRestrictions.Insertable: true,
        UpdateRestrictions.Updatable : true,
        DeleteRestrictions.Deletable : false,
        ReadRestrictions.Readable    : false
    }
    entity EmployeeService   as projection on db.masterdata.Employees;

    entity salesOrderService as projection on db.transaction.SalesOrders
    {
        *,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'In Process'
            when 'C' then 'Completed'
            else 'Unknown'
        end as OST : String(15) @title : '{i18n>OVERALL_STATUS}',
        case LIFECYCLE_STATUS
            when 'N' then 'Not Paid'
            when 'P' then 'Paid'
            when 'C' then 'Completed'
            when 'D' then 'Delivered'
            else 'Unknown'
        end as LST : String(15) @title : '{i18n>LIFECYCLE_STATUS}',
        case OVERALL_STATUS
            when 'N' then 1
            when 'P' then 2
            when 'C' then 3
            else 0
        end as OSC : Integer,
        case LIFECYCLE_STATUS
            when 'N' then 1
            when 'P' then 2
            when 'C' then 3
            when 'D' then 1
            else 0
        end as LSC : Integer
    } actions { 
         @cds.odata.bindingparameter.name : 'discount'
         @Common.SideEffects: {
            TargetProperties : [ 'discount/GROSS_AMOUNT', 'discount/NET_AMOUNT', 'discount/TAX_AMOUNT' ],
         }
         action discountPrice();
        };
    entity SalesItemService  as projection on db.transaction.SalesItems;

    function gethighestSalary() returns array of String;

    action   CreateEmployee(
                            ID: UUID,
                            Name: reuse.Name,
                            NAMEFIRST: reuse.Name,
                            NAMELAST: reuse.Name,
                            NAMEINITIAL: reuse.Name,
                            NAMEMIDDLE: reuse.Name,
                            GENDER: reuse.Gender,
                            LANGUAGE_code: String,
                            PHONE: reuse.Phonenumber,
                            EMAIL: reuse.Email,
                            EMPLOYEEID: Integer,
                            LOGINNAME: reuse.Name,
                            CURRENCY_code: String,
                            SALARY: reuse.AmountT,
                            ACCOUNTNUMBER: String(16),
                            BANKID: String(16),
                            BANKNAME: String(255), ) returns array of String;
                        
}
