@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airline'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_Dimension_Airline
  as select from I_CalendarDate
{
  key CalendarDate,
      CalendarYear,
      CalendarQuarter,
      CalendarMonth,
      CalendarWeek,
      CalendarDay,
      YearMonth,
      YearQuarter,
      YearWeek,
      WeekDay,
      FirstDayOfWeekDate,
      FirstDayOfMonthDate,
      LastDayOfMonthDate,
      CalendarDayOfYear,
      YearDay,
      /* Associations */
      _CalendarMonth,
      _CalendarQuarter,
      _CalendarWeek,
      _CalendarYear,
      _WeekDay,
      _YearMonth,
      _YearWeek
}
