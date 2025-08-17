@AbapCatalog.sqlViewName: 'ZCDS_LEFTOUTER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Left Outer Join'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_LEFT_OUTER
  as select from    /dmo/carrier as carrier
    //right outer join /dmo/flight  as _flight on carrier.carrier_id = _flight.carrier_id
    cross join /dmo/flight as _flight
{
  key carrier.carrier_id as CarrierId,
      carrier.name       as Name,
      _flight.connection_id,
      _flight.flight_date,
      _flight.price

}
