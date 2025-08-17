@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for travel entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
@UI: {
    headerInfo : {
        typeName: 'Travel',
        typeNamePlural: 'Travels',
        title: {
            type: #STANDARD,
            value: 'TravelID'
        }
    }
}
define root view entity ZC_RAP_TRAV_DEMO as projection on ZI_RAP_TRAV_01
{
    key TravelId,
    @Consumption.valueHelpDefinition: [{ entity: {
        name: '/DMO/I_AGENCY',
        element: 'AgencyID'
    } }]
    @ObjectModel.text.element: [ 'AgencyName' ]
    @Search.defaultSearchElement: true
    AgencyId,
    _Agency.Name as AgencyName,
    @Consumption.valueHelpDefinition: [{ entity: {
        name: '/DMO/I_Customer',
        element: 'CustomerID'
    } }]
    @ObjectModel.text.element: [ 'CustomerName' ]
    @Search.defaultSearchElement: true
    CustomerId,
    _Customer.FirstName as CustomerName,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    CurrencyCode,
    Description,
    Status,
    Lastchangedat,
    /* Associations */
    _Agency,
    _Booking : redirected to composition child ZC_RAP_BOOK_DEMO,
    _Currency,
    _Customer
}
