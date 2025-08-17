@AbapCatalog.sqlViewName: 'ZCDS_FLIGHT_001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view for Flight table'
@Metadata.ignorePropagatedAnnotations: true
//define view ZCDS_flight
//  as select from /dmo/flight  as flight
//    inner join   /dmo/carrier as _carrier on flight.carrier_id = _carrier.carrier_id
//{
//  key flight.carrier_id     as CarrierId,
//  key flight.connection_id  as ConnectionId,
//  key flight.flight_date    as FlightDate,
//      flight.seats_max      as SeatsMax,
//      flight.seats_occupied as SeatsOccupied,
//      'CONSTANT'            as const,
//      _carrier.name         as CarrierName
//}
@VDM.viewType: #BASIC
define view ZCDS_flight
  as select from /dmo/flight as flight
{
  *
}
