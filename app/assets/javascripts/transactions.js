function initializeMainDataTable() {
  $("#transaction-table").dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "iDisplayLength": 10,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $("#transaction-table").data("source"),
    "aoColumns": [
                   null,
                   null,
                   null,
                   null,
                   { "asSorting": [] },
                 ],
  });
  
  $(".date-selector").datepicker({
    changeYear: true,
    maxDate: new Date,
    yearRange: '-90:+0',
    buttonImage: "calendar.gif",
    buttonImageOnly: true,
    showOn: 'button',
    dateFormat: 'yy-mm-dd',
    onSelect: function(dateText, inst) {
      $(".load-indicator").fadeIn();
      $.ajax({
        type: 'post',
        url: '/transactions/refresh_main_table',
        data: {"date": dateText}, 
        success: function() {
          $(".load-indicator").fadeOut();
        }
      });
    }
  });
}

$(document).ready(function() {
  initializeMainDataTable();
});
