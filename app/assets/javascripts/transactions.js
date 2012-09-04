function initializeMainDataTable() {
  $("#transaction-table").dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<p>>",
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
                   { "asSorting": [] }
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

function initializeCustomerDataTable() {
  $("#customer-table").dataTable({
    "sDom": "<'row-fluid'<f>r>t<'row-fluid'<p>>",
    "sPaginationType": "bootstrap",
    "iDisplayLength": 10,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $("#customer-table").data("source"),
    "aaSorting": [[ 0, "desc" ]],
    "aoColumns": [
                   { "asSorting": [], "sWidth": '1%' },
                   { "sWidth": '8%' },
                   { "sWidth": '8%' }
                 ],
  });
}

function initializeButtons() {
  $(".add-customer-btn").live("click", function() {
    var me = $(this),
        id = me.attr("c_id"),
        name = me.attr("c_name");

    if($("#customer-pool").find("div."+id).size()==0) {
      $("#customer-pool").append("<div class='alert alert-info "+id+"'>"+
                                   "<button type='button' class='close' data-dismiss='alert'>×</button>"+
                                   name+
                                 "</div>");
    }
  });
}

$(document).ready(function() {
  initializeMainDataTable();
  initializeCustomerDataTable();
  initializeButtons();
});
