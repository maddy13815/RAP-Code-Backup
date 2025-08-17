@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Entity for booking'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_RAP_BOOK_DEMO
  as select from /dmo/booking as Booking
  association        to parent ZI_RAP_TRAV_01 as _Travel     on  $projection.TravelId = _Travel.TravelId
  association [1..1] to /DMO/I_Customer       as _Customer   on  $projection.CustomerId = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier        as _Carrier    on  $projection.AirlineID = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection     as _Connection on  $projection.AirlineID    = _Connection.AirlineID
                                                             and $projection.ConnectionId = _Connection.ConnectionID
{
  key Booking.travel_id     as TravelId,
  key Booking.booking_id    as BookingId,
      Booking.booking_date  as BookingDate,
      Booking.customer_id   as CustomerId,
      Booking.carrier_id    as AirlineID,
      Booking.connection_id as ConnectionId,
      Booking.flight_date   as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Booking.flight_price  as FlightPrice,
      Booking.currency_code as CurrencyCode,
      _Travel,
      _Customer,
      _Carrier,
      _Connection

}
