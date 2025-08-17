@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity of Billing Header'
define root view entity ZRAP_BILL_HEADER
  as select from ztab_bill_header
  composition [0..*] of ZRAP_I_BILL_ITEM as _item
{
  key bill_id     as BillId,
      bill_type   as BillType,
      bill_date   as BillDate,
      customer_id as CustomerId,
      @Semantics.amount.currencyCode: 'Currency'
      net_amount  as NetAmount,
      currency    as Currency,
      sales_org   as SalesOrg,

      _item
}
