@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS association'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
define view entity ZCDS_ASSOC
  as select from /dmo/carrier as carrier
  //    left outer join /dmo/flight  as _flight on _flight.carrier_id = carrier.carrier_id
  association [0..*] to ZCDS_flight as _flight on _flight.CARRIER_ID = $projection.CarrierId
{
  key carrier.carrier_id  as CarrierId,
      carrier.name        as Name,
      //Adhoc Association
      _flight.FLIGHT_DATE as FlDate,
      carrier.last_changed_at,
      carrier.currency_code,
      //      _flight.plane_type_id

      //Exposed Association
      _flight
}
