@AbapCatalog.sqlViewName: 'ZDIMEAIRLINE'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Airline'

@Analytics.dataCategory: #DIMENSION

define view Z_Dimension_Airline
  as select from /dmo/carrier
{
      @ObjectModel.text.element: [ 'AirlineName' ]
  key carrier_id    as Airline,

      @Semantics.text: true
      name          as AirlineName,

      @Semantics.currencyCode: true
      currency_code as Currency
}
