@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View of Billing Doc Header'
@Metadata.allowExtensions: true
define root view entity zrap_c_bill_header
  provider contract transactional_query
  as projection on ZRAP_BILL_HEADER
{
  key BillId,
      BillType,
      BillDate,
      CustomerId,
      NetAmount,
      Currency,
      SalesOrg,

      _item : redirected to composition child ZRAP_C_BILL_ITEM
}
