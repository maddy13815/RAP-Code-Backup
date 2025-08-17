@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Billing Doc Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZRAP_I_BILL_ITEM
  as select from ztab_bill_item
  association to parent ZRAP_BILL_HEADER as _header on $projection.BillId = _header.BillId
{
  key bill_id     as BillId,
  key item_no     as ItemNo,
      material_id as MaterialId,
      description as Description,
      @Semantics.amount.currencyCode: 'Currency'
      item_amount as ItemAmount,
      currency    as Currency,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      quantity    as Quantity,
      uom         as Uom,
      
      _header
}
