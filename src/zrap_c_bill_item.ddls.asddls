@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view of billing doc item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZRAP_C_BILL_ITEM
  as projection on ZRAP_I_BILL_ITEM
{
  key BillId,
  key ItemNo,
      MaterialId,
      Description,
      @Semantics.amount.currencyCode: 'Currency'
      ItemAmount,
      Currency,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      Quantity,
      Uom,
      /* Associations */
      _header: redirected to parent zrap_c_bill_header
}
