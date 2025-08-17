@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for Booking entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZC_RAP_BOOK_DEMO
  as projection on ZI_RAP_BOOK_DEMO
{
      @Search.defaultSearchElement: true
  key TravelId,
      @Search.defaultSearchElement: true
  key BookingId,
      BookingDate,
      @Consumption.valueHelpDefinition: [{ entity: {
         name: '/DMO/I_Customer',
         element: 'CustomerID'
      } }]
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Search.defaultSearchElement: true
      CustomerId,
      _Customer.FirstName as CustomerName,
      @Consumption.valueHelpDefinition: [{ entity: {
        name: '/DMO/I_Carrier',
        element: 'AirlineID'
      } }]
      @ObjectModel.text.element: [ 'AirlineName' ]
      @Search.defaultSearchElement: true
      AirlineID,
      _Carrier.Name       as AirlineName,
      @Consumption.valueHelpDefinition: [{ entity: {
      name: '/DMO/I_Flight',
      element: 'ConnectionID'
      },
        additionalBinding: [
           {localElement: 'FlightDate', element: 'FlightDate'},
            {localElement: 'AirlineID', element: 'AirlineID'},
            {localElement: 'FlightPrice', element: 'Price'},
            {localElement: 'CurrencyCode', element: 'CurrencyCode'}
         ]
       }]
      ConnectionId,
      @Consumption.valueHelpDefinition: [{ entity: {
      name: '/DMO/I_Flight',
      element: 'FlightDate'
      },
      additionalBinding: [
      {localElement: 'ConnectionID', element: 'ConnectionID'},
      {localElement: 'AirlineID', element: 'AirlineID'},
      {localElement: 'FlightPrice', element: 'Price'},
      {localElement: 'CurrencyCode', element: 'CurrencyCode'}
      ]
      }]
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      @Consumption.valueHelpDefinition: [{ entity: {
        name: 'I_Currency',
        element: 'Currency'
      } }]
      CurrencyCode,
      /* Associations */
      _Carrier,
      _Connection,
      _Customer,
      _Travel: redirected to parent ZC_RAP_TRAV_DEMO
}
