hash = window.location.hash
hash and $("ul.nav a[href=\"" + hash + "\"]").tab("show")
$(".nav-tabs a").click (e) ->
  $(this).tab "show"
  scrollmem = $("body").scrollTop()
  window.location.hash = @hash
  $("html,body").scrollTop scrollmem

$("#financials a.btn").on "click", ->
  ajaxManager("get", "/reports/refresh_financials", {})

ajaxManager = (type, url, data) ->
  $(".load-indicator").fadeIn()
  $.ajax
    type: type
    url: url
    data: data
    success: ->
      $(".load-indicator").fadeOut()

window.initializePerformanceDataTable = ->
  $("#performance-date-selector").datepicker
    changeYear: true
    yearRange: "-90:+0"
    buttonImage: "calendar.gif"
    buttonImageOnly: true
    showOn: "button"
    dateFormat: "yy-mm-dd"
    onSelect: (dateText, inst) ->
      ajaxManager "get", "/reports/refresh_performance",
        date: dateText


  $("#performance-table").dataTable
    "sDom": "<'row-fluid'r>t<'row-fluid'<l><p>>",
    sPaginationType: "bootstrap"
    iDisplayLength: 10
    bProcessing: true
    bServerSide: true
    sAjaxSource: $("#performance-table").data("source")
    aaSorting: [[0, "desc"]]
    aoColumns: [null,
      sWidth: "20%"
    ,
      sWidth: "11%"
    ]

window.initializeFinancialDataTable = ->
  $("#financials-table").dataTable(
    "sDom": "<'row-fluid'r>t<'row-fluid'<l><p>>",
    sPaginationType: "bootstrap"
    iDisplayLength: 10
    bProcessing: true
    bServerSide: true
    sAjaxSource: $("#financials-table").data("source")
    aaSorting: [[2, "desc"]]
    aoColumns: [null, null, null, null, null, null]
  ).makeEditable
    sUpdateURL: "/reports/update_financials"
    aoColumns: [null, null, null, null, {}, null]

initializePerformanceDataTable()
initializeFinancialDataTable()
