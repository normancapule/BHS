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
                 ]
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
    "aaSorting": [[ 2, "desc" ]],
    "aoColumns": [
                   { "asSorting": [], "sWidth": '1%' },
                   { "sWidth": '8%' },
                   { "sWidth": '8%' }
                 ]
  });
  
  $(".transaction-date-selector").datepicker({
    changeYear: true,
    maxDate: new Date,
    yearRange: '-90:+0',
    dateFormat: 'yy-mm-dd'  
  });
}

function initializeServiceDataTable() {
  $("#service-table").dataTable({
    "sDom": "<'row-fluid'<'span6'f>r>t<'row-fluid'<p>>",
    "sPaginationType": "bootstrap",
    "iDisplayLength": 10,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $("#service-table").data("source"),
    "aaSorting": [[ 1, "desc" ]],
    "aoColumns": [
                   { "asSorting": [], "sWidth": '1%' },
                   { "sWidth": '10%' },
                   { "asSorting": [], "sWidth": '1%' }
                 ]
  });
}

function ajaxManager(type, url, data, modal_flag, crud) {
  $(".load-indicator").fadeIn();
  $.ajax({
    type: type,
    url: url,
    data: data,
    success: function() {
      $(".load-indicator").fadeOut();
      if(modal_flag) {
        $("#step1.modal").modal('show');
        $("h3.transaction-modal-title").text(crud+" Transaction");
      }
    }
  });
}

function initializeButtons() {
  $(".add-dialog").live("click", function() {
    $(".modal-backdrop").remove();
    ajaxManager('post', '/transactions/initialize_transaction_modal', {}, true, "Create a New");
  });

  $(".edit-btn").live("click", function() {
    var me = $(this),
        t_id = me.attr("t_id");
    $(".modal-backdrop").remove();
    ajaxManager('post', '/transactions/initialize_transaction_modal', {"transaction_id": t_id}, true, "Update a");
  });
  
  $(".add-customer-btn").live("click", function() {
    var me = $(this),
        id = me.attr("c_id"),
        transaction_id = $("#transaction_id").val();
    ajaxManager('post', '/transactions/select_customer', {"id": id, "transaction_id": transaction_id}, false, "");
  });

  $(".transition").live("click", function() {
    var me = $(this);
    me.parent().parent().modal('hide');
  });
  
  $(".add-service-btn").live("click", function() {
    var me = $(this),
        id = me.attr("s_id"),
        name = me.attr("s_name"),
        price = me.parents("tr:first").children("td:last").text(), sum = 0;

    if($(".service-pool").find("div."+id).size()==0) {
      $(".service-pool").append("<div class='alert alert-info alert-block "+id+" selected-service' cost="+price+">"+
                                "<button type='button' class='close' data-dismiss='alert'>×</button>"+
                                name+
                                "</div>");
    }
  });
  
  $(".am-pm-selector").live("change", function(){
    var me = $(this),
        customer = $(".customer-pool table").attr("c_id"),
        transaction_id = $("#transaction_id").val(),
        value = me.find("option:selected").val();
    ajaxManager('post', '/transactions/select_service_time', {"am_pm": value, "id": customer, "transaction_id": transaction_id}, false);
  });

  $(".add-service-btn, .selected-service .close").live("click", function(){
    var sum = 0;
    $(".service-pool").children(".alert").each(function() {
        sum += parseFloat($(this).attr("cost"));
    })
    $("#total-cost").val(sum);
  });
}

$(document).ready(function() {
  initializeMainDataTable();
  initializeButtons();
});
