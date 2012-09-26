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
  return "<div class='alert alert-error'>"+
           "<button type='button' class='close' data-dismiss='alert'>×</button>"+
           message +
         "</div>";
}

function initializeAddDialog() {
  $("#account_birthday").datepicker({
    changeYear: true,
    maxDate: new Date,
    yearRange: '-90:+0',
    dateFormat: 'yy-mm-dd'
  });
  
  $("#add-customer").dialog({
    title: "Add a Customer",
    autoOpen: true,
    width: '40%',
    height: '400',
    modal: true,
    resizable: false,
    buttons: {
      "Save": function() {
        $("#new-customer").submit()
      },
      "Close": function() {
        $(this).dialog("close");
      }
    }
  });
}

function initializeEditDialog() {
  $("#account_birthday").datepicker({
    changeYear: true,
    maxDate: new Date,
    yearRange: '-90:+0',
    dateFormat: 'yy-mm-dd'
  });
  
  $("#edit-customer").dialog({
    title: "Edit a Customer",
    autoOpen: true,
    width: '40%',
    height: '400',
    modal: true,
    resizable: false,
    buttons: {
      "Save": function() {
        $("#edit-customer-form").submit()
      },
      "Close": function() {
        $(this).dialog("close");
      }
    }
  });
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
    ajaxManager('get', '/customers/add');
  });

  $("a.edit-btn").live("click", function() {
    var me = $(this);
    ajaxManager('get', '/customers/'+me.attr('c_id')+'/edit');
  });
  
  $("#edit-customer-form, #new-customer").live('submit', function(e) {
    e.preventDefault();
    var flag = true,
        me = $(this),
        parent = me.parent();
    if(parent.find("#account_firstname").val().length == 0) {
      flag = false;
    }
    
    if(parent.find("#account_lastname").val().length == 0) {
      flag = false;
    }
    
    if(parent.find("#card_number").val().length == 0 && parent.find("#account_membership").val() > 0) {
      flag = false;
    }
    
    if(flag) {
      console.log(me.attr('action'));
      ajaxManager("post", me.attr('action'), me.serialize());
    } else {
      parent.prepend(errorMaker("Please fill out all required data."));
    }
  });

  $("#account_membership").live('change', function() {
    var me = $(this);
    if(me.val() > 0)
      $("div.card-number").show();
    else
      $("div.card-number").hide();
  });

  $("a.delete-btn").live('click', function() {
    var me = $(this);
    ajaxManager("delete", "/customers/"+me.attr("c_id"), {});
  });
}

$(document).ready(function() {
  initializeDataTable();
  initializeButtons();
});
