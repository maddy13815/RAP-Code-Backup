@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection Entity for Connection'
@ObjectModel.semanticKey: [ 'CarrierId', 'ConnectionId' ]
@Search.searchable: true

define view entity zrap_c_connection
  as projection on zrap_i_connection
{
  key CarrierId,
  @Search.defaultSearchElement: true
  key ConnectionId,
      AirportFromId,
      AirportToId,
      DepartureTime,
      ArrivalTime,
      Distance,
      DistanceUnit,
      /* Associations */
      _Carrier : redirected to parent Zrap_C_CARRIER
}
