using SalesOrderAppServices as service from '../../srv/service';

annotate service.salesOrderService with @(
    UI.SelectionFields       : [
        SO_ID,
        GROSS_AMOUNT,
        PARTNER.COMPANY_NAME,
        PARTNER.ADDRESS.Country
    ],
    UI.LineItem              : [
        { $Type: 'UI.DataField', Value : SO_ID },
        { $Type: 'UI.DataField', Value : PARTNER.COMPANY_NAME },
        { $Type: 'UI.DataField', Value : PARTNER.BP_ID },
        { $Type: 'UI.DataField', Value : GROSS_AMOUNT },
        { $Type: 'UI.DataFieldForAction', Action : 'SalesOrderAppServices.discountPrice', Label : 'Discount Price', Inline : true },
        { $Type: 'UI.DataField', Value : CURRENCY_code },
        { $Type: 'UI.DataField', Value : LST , Criticality: LSC },
        { $Type: 'UI.DataField', Value : OST , Criticality: OSC },
        { $Type: 'UI.DataField', Value : PARTNER.ADDRESS.Country}
    ],

    UI.HeaderInfo          : {
        TypeName      : 'Sales Order',
        TypeNamePlural: 'Sales Orders',
        Title         : { $Type: 'UI.DataField', Value: SO_ID },
        Description   : { $Type: 'UI.DataField', Value: PARTNER.COMPANY_NAME },
        ImageUrl      : 'https://logodownload.org/wp-content/uploads/2019/08/tata-motors-logo-0.png'
    },

    UI.Facets : [
    {
        $Type: 'UI.CollectionFacet',
        Label : 'Sales Order Details',
        Facets : [ {
           $Type : 'UI.ReferenceFacet',
           Label: 'More Details about the sales order',
           Target : '@UI.FieldGroup#MoreInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label: 'Amount details about the sales order',
            Target : '@UI.FieldGroup#AmountDetails'
        }
     ]
    },
    {
        $Type: 'UI.ReferenceFacet',
        Label : 'Sales Order Items',
        Target : 'Items/@UI.LineItem'
    }
    ],

    UI.FieldGroup #MoreInfo : {
            $Type: 'UI.FieldGroupType',
            Data : [
                { $Type: 'UI.DataField', Value : SO_ID },
                { $Type: 'UI.DataField', Value : PARTNER.BP_ID },
                { $Type: 'UI.DataField', Value : LST , Criticality: LSC },
                { $Type: 'UI.DataField', Value : OST , Criticality: OSC }
            ]
    },
    UI.FieldGroup #AmountDetails :  {
            $Type: 'UI.FieldGroupType',
            Data : [
                { $Type: 'UI.DataField', Value : GROSS_AMOUNT },
                { $Type: 'UI.DataField', Value : NET_AMOUNT },
                { $Type: 'UI.DataField', Value : TAX_AMOUNT },
                { $Type: 'UI.DataField', Value : CURRENCY_code }
            ]
        }
);

annotate service.SalesItemService with @(
    UI.SelectionFields       : [
        PO_ITEMS_POS,
        PRODUCT.NODE_KEY,
        GROSS_AMOUNT
    ],
    UI.LineItem : [
        { $Type: 'UI.DataField', Value : PO_ITEMS_POS },
        { $Type: 'UI.DataField', Value : PRODUCT.NODE_KEY },
        { $Type: 'UI.DataField', Value : GROSS_AMOUNT },
        { $Type: 'UI.DataField', Value : NET_AMOUNT },
        { $Type: 'UI.DataField', Value : TAX_AMOUNT },
        { $Type: 'UI.DataField', Value : CURRENCY_code }
    ],

    UI.HeaderInfo         : {
        TypeName      : 'Sales Order Item',
        TypeNamePlural: 'Sales Order Items',
        Title         : { $Type: 'UI.DataField', Value: PO_ITEMS_POS },
        Description   : { $Type: 'UI.DataField', Value: PRODUCT.DESCRIPTION },
        ImageUrl : 'https://logodownload.org/wp-content/uploads/2019/08/tata-motors-logo-0.png'
    },
    UI.Facets : [
    {
        $Type: 'UI.CollectionFacet',
        Label : 'Sales Order Item Details',
        Facets : [ {
           $Type : 'UI.ReferenceFacet',
           Label: 'Price Details about the sales order item',
           Target : '@UI.FieldGroup#ItemsPriceInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label: 'Product details about the sales order item',
            Target : '@UI.FieldGroup#ItemProductInfo'
        }
     ]
    }
    ],
    UI.FieldGroup #ItemsPriceInfo : {
            $Type: 'UI.FieldGroupType',
            Data : [
                { $Type: 'UI.DataField', Value : GROSS_AMOUNT },
                { $Type: 'UI.DataField', Value : NET_AMOUNT },
                { $Type: 'UI.DataField', Value : TAX_AMOUNT },
                { $Type: 'UI.DataField', Value : CURRENCY }
            ]
    },
    UI.FieldGroup #ItemProductInfo :  {  
            $Type: 'UI.FieldGroupType',
                Data : [
                    { $Type: 'UI.DataField', Value : PRODUCT.PRODUCT_ID },
                    { $Type: 'UI.DataField', Value : PRODUCT.DESCRIPTION },
                    { $Type: 'UI.DataField', Value : PRODUCT.CATEGORY },
                    { $Type: 'UI.DataField', Value : PRODUCT.PRICE },
                    { $Type: 'UI.DataField', Value : PRODUCT.CURRENCY_CODE },
                    { $Type: 'UI.DataField', Value : PRODUCT.MEASURE_UNIT },
                    { $Type: 'UI.DataField', Value : PRODUCT.WEIGHT_MEASURE },
                    { $Type: 'UI.DataField', Value : PRODUCT.WEIGHT_UNIT },
                    { $Type: 'UI.DataField', Value : PRODUCT.WIDTH },
                    { $Type: 'UI.DataField', Value : PRODUCT.DEPTH },
                    { $Type: 'UI.DataField', Value : PRODUCT.HEIGHT },
                    { $Type: 'UI.DataField', Value : PRODUCT.DIM_UNIT }
                ]
            } 
);

