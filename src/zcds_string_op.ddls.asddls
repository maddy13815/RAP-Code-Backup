@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'String Opeation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_STRING_OP
  as select from /dmo/carrier
{
  key carrier_id                                   as CarrierId,
      name                                         as Name,
      local_created_by                             as LocalCreatedBy,
      concat(name, local_created_by)               as concats,
      concat_with_space(name, local_created_by, 1) as concatwithspace,
      lower(local_created_by)                      as lowercase,
      replace(local_created_by, 'G', 'Q')          as replacedstring,

      substring(name, 3, 5)                        as substringaa
}
