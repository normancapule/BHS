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
  $("#add-service").dialog({
    title: "Add a Service",
    autoOpen: true,
    width: '40%',
    height: '400',
    modal: true,
    resizable: false,
    buttons: {
      "Save": function() {
        $("#new-service").submit()
      },
      "Close": function() {
        $(this).dialog("close");
      }
    }
  });
}

function initializeEditDialog() {
  $("#edit-service").dialog({
    title: "Edit a Service",
    autoOpen: true,
    width: '40%',
    height: '400',
    modal: true,
    resizable: false,
    buttons: {
      "Save": function() {
        $("#edit-service-form").submit()
      },
      "Close": function() {
        $(this).dialog("close");
      }
    }
  });
}

function initializeDataTable() {
  $("#service-table").dataTable({
    "sDom": "<'row-fluid'<f>r>t<'row-fluid'<l><p>>",
    "sPaginationType": "bootstrap",
    "iDisplayLength": 10,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $("#service-table").data("source"),
    "aaSorting": [[ 0, "desc" ]],
    "aoColumns": [
                   null,
                   null,
                   null,
                   null,
                   null,
                   { "bSortable": false, "sWidth": "11%" }
                 ]
  });
}

function initializeButtons() {
  $(".add-dialog").live("click", function() {
    ajaxManager('get', '/services/add');
  });

  $("a.edit-btn").live("click", function() {
    var me = $(this);
    ajaxManager('get', '/services/'+me.attr('s_id')+'/edit');
  });
  
  $("#edit-service-form, #new-service").live('submit', function(e) {
    e.preventDefault();
    var flag = true,
        me = $(this),
        parent = me.parent();
    if(parent.find("#service_name").val().length == 0) {
      flag = false;
    }
    
    if(flag) {
      console.log(me.attr('action'));
      ajaxManager("post", me.attr('action'), me.serialize());
    } else {
      parent.prepend(errorMaker("Please fill out all required data."));
    }
  });

  $("a.delete-btn").live('click', function() {
    var me = $(this);
    ajaxManager("delete", "/services/"+me.attr("s_id"), {});
  });
}

$(document).ready(function() {
  initializeDataTable();
  initializeButtons();
});

