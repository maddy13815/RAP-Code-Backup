@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Expression and operation code piushdown'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_EXPRESSION
  as select from /dmo/flight
{
  key carrier_id     as CarrierId,
  key connection_id  as ConnectionId,
  key flight_date    as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price          as Price,
      currency_code  as CurrencyCode,
      plane_type_id  as PlaneTypeId,
      case
        when plane_type_id like '7%' //% means any string
           then 'Boeing'
        when plane_type_id like 'A%'
            then 'Airbus'
         else 'Other Manufactuter'
         end         as plane_manufacturer,

      seats_max      as SeatsMax,
      seats_occupied as SeatsOccupied,
      //      'Flight'                 as Title,
      //      20                       as Num1,
      //      $session.user            as username,
      //      $session.client          as Clients,
      //      $session.system_language as sysLangu

      case currency_code
           when 'USD' then 'United States'
           when 'EUR' then 'European Unioun'
           else 'Others'
           end       as Desc_curr_code,

      case
       when price <= 1000
           then 'Cheap'
       when price > 1000 and price <= 5000
           then 'Moderate'
       when price > 5000
           then 'Expensive'
       else
         'Wrong value'
         end         as PriceBudget

}
