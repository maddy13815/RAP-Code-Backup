@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection Entity for Carrier'
@ObjectModel.semanticKey: [ 'CarrierId' ]
@Search.searchable: true

define root view entity Zrap_C_CARRIER
  provider contract transactional_query
  as projection on Zrap_I_CARRIER
{
  key CarrierId,
      @Search.defaultSearchElement: true
      Name,
      CurrencyCode,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _Connection : redirected to composition child zrap_c_connection
}
