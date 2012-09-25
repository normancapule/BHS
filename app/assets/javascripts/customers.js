function ajaxManager(type, url, data) {
  $(".load-indicator").fadeIn();
  $.ajax({
    type: type,
    url: url,
    data: data,
    success: function() {
      $(".load-indicator").fadeOut();
    }
  });
}

function errorMaker(message) {
  return "<div class='alert alert-error reservation-errors'>"+
           "<button type='button' class='close' data-dismiss='alert'>×</button>"+
           message +
         "</div>";
}

function initializeDataTable() {
  $("#customer-table").dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<p>>",
    "sPaginationType": "bootstrap",
    "iDisplayLength": 10,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $("#customer-table").data("source"),
    "aaSorting": [[ 1, "desc" ]],
    "aoColumns": [
                   null,
                   null,
                   null,
                   { "asSorting": [] },
                 ],
  });
}

function initializeButtons() {
  $(".add-dialog").live("click", function() {
    $("#add-customer").dialog("open"); 
  });

  $("#account_birthday").datepicker({
    changeYear: true,
    maxDate: new Date,
    yearRange: '-90:+0',
    dateFormat: 'yy-mm-dd',
  });
}

$(document).ready(function() {
  initializeDataTable();
  initializeButtons();
});
