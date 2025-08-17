@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'view entityt'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_VIEW_ENTITY
  as select from /dmo/flight
{
  key carrier_id                                as CarrierId,
  key connection_id                             as ConnectionId,
  key flight_date                               as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                                     as Price,
      currency_code                             as CurrencyCode,
      plane_type_id                             as PlaneTypeId,
      seats_max                                 as SeatsMax,
      seats_occupied                            as SeatsOccupied,

      dats_add_days(flight_date, 7, 'INITIAL' ) as DaysAfter1Week,
      dats_add_months(flight_date, 1, 'NULL')   as Dateafter1month
}
