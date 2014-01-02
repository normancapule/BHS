window.ajaxManager = (type, url, data) ->
  $(".load-indicator").fadeIn()
  $.ajax
    type: type
    url: url
    data: data
    success: ->
      $(".load-indicator").fadeOut()

errorMaker = (message) ->
  "<div class='alert alert-error'>" + "<button type='button' class='close' data-dismiss='alert'>×</button>" + message + "</div>"
window.initializeAddDialog = ->
  $("#add-package").dialog
    title: "Add a package"
    autoOpen: true
    width: "40%"
    height: "400"
    modal: true
    resizable: false
    buttons:
      Save: ->
        $("#new-package").submit()

      Close: ->
        $(this).dialog "close"

window.initializeEditDialog = ->
  $("#edit-package").dialog
    title: "Edit a package"
    autoOpen: true
    width: "40%"
    height: "400"
    modal: true
    resizable: false
    buttons:
      Save: ->
        $("#edit-package-form").submit()

      Close: ->
        $(this).dialog "close"

window.initializeDataTable = ->
  $("#package-table").dataTable
    sDom: "<'row-fluid'<f>r>t<'row-fluid'<l><p>>"
    sPaginationType: "bootstrap"
    iDisplayLength: 10
    bProcessing: true
    bServerSide: true
    sAjaxSource: $("#package-table").data("source")
    aaSorting: [[0, "desc"]]
    aoColumns: [null, null,
      {bSortable: false}
      ,
      {bSortable: false
      sWidth: "11%"}
    ]

window.initializeButtons = ->
  $(".add-dialog").live "click", ->
    ajaxManager "get", "/packages/add"

  $("a.edit-btn").live "click", ->
    me = $(this)
    ajaxManager "get", "/packages/" + me.attr("s_id") + "/edit"

  $("#edit-package-form, #new-package").live "submit", (e) ->
    e.preventDefault()
    flag = true
    me = $(this)
    parent = me.parent()
    flag = false  if parent.find("#service_name").val().length is 0
    if flag
      console.log me.attr("action")
      ajaxManager "post", me.attr("action"), me.serialize()
    else
      parent.prepend errorMaker("Please fill out all required data.")

  $("a.delete-btn").live "click", ->
    me = $(this)
    ajaxManager "delete", "/packages/" + me.attr("s_id"), {}

initializeDataTable()
initializeButtons()
