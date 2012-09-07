function ajaxManager(type, url, data, display_modal, title) {
  display_modal = typeof display_modal == 'undefined' ? false : display_modal;
  title = typeof title == 'undefined' ? "" : title;

  $(".load-indicator").fadeIn();
  $.ajax({
    type: type,
    url: url,
    data: data,
    success: function() {
      $(".load-indicator").fadeOut();
      if(display_modal) {
        $("#step1.modal").modal('show');
        $("h3.transaction-modal-title").text(title+" Transaction");
      }     
    }
  });
}

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
  
  $("#transaction-list-date-selector").datepicker({
    changeYear: true,
    maxDate: new Date,
    yearRange: '-90:+0',
    buttonImage: "calendar.gif",
    buttonImageOnly: true,
    showOn: 'button',
    dateFormat: 'yy-mm-dd',
    onSelect: function(dateText, inst) {
      ajaxManager('post', '/transactions/refresh_main_table', {"date": dateText});
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
  
  $("#transaction-form-date-selector").datepicker({
    changeYear: true,
    maxDate: new Date,
    yearRange: '-90:+0',
    dateFormat: 'yy-mm-dd'  
  });
}

function initializeServiceDataTable() {
  $("#service-table").dataTable({
    "sDom": "<'row-fluid'<f>r>t<'row-fluid'<p>>",
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

function initializeButtons() {
  $(".add-btn").live("click", function() {
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
    ajaxManager('post', '/transactions/select_customer', {"id": id, "transaction_id": transaction_id});
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
      $(".service-pool").append("<div class='alert alert-info alert-block "+id+" selected-service' cost="+price+" s_id="+id+">"+
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
  
  $("a.btn.submit").live("click", function() {
    var me = $(this),
        services = [],
        step1 = $("#step1"), step2 = $("#step2"), step3 = $("#step3"),
        transaction_id = step1.find("#transaction_id").val(),
        customer_id = step1.find("#customer_id").val(),
        transaction_type = step2.find("#am-pm-selector").val(),
        total_cost = step2.find("#total-cost").val(),
        therapist_id = step3.find("#therapists option:selected").val(),
        transac_date = step3.find("#transaction-form-date-selector").val(),
        notes = step3.find("#notes").val(), 
        url = "/transactions/", 
        data = {},
        type = "post";
        
    step2.find(".service-pool").children(".selected-service").each(function(i){ services[i] = $(this).attr('s_id'); });
    data["transaction"] = {
                            "id": transaction_id,
                            "transaction_type": transaction_type,
                            "customer_id": customer_id,
                            "therapist_id": therapist_id,
                            "total_price": total_cost,
                            "transac_date": transac_date,
                            "notes": notes
                          };
    data["services"] = services;
    if(transaction_id != "") {
      type="put"
      url += transaction_id
    }
    ajaxManager(type, url, data);
  });

  $(".paid-btn").live("click", function(){
    var me = $(this);
    ajaxManager("post", "/transactions/paid", {"id": me.attr("t_id"), "paid": me.attr("checked")});
  });
  
  $(".delete-btn").live("click", function(){
    var me = $(this);
    ajaxManager("delete", "/transactions/"+me.attr("t_id"), {});
  });
}

$(document).ready(function() {
  initializeMainDataTable();
  initializeButtons();
});
