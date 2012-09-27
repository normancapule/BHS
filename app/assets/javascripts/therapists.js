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
  $("#add-therapist").dialog({
    title: "Add a Therapist",
    autoOpen: true,
    width: '40%',
    height: '400',
    modal: true,
    resizable: false,
    buttons: {
      "Save": function() {
        $("#new-therapist").submit()
      },
      "Close": function() {
        $(this).dialog("close");
      }
    }
  });
}

function initializeEditDialog() {
  $("#edit-therapist").dialog({
    title: "Edit a Therapist",
    autoOpen: true,
    width: '40%',
    height: '400',
    modal: true,
    resizable: false,
    buttons: {
      "Save": function() {
        $("#edit-therapist-form").submit()
      },
      "Close": function() {
        $(this).dialog("close");
      }
    }
  });
}

function initializeDataTable() {
  $("#therapist-table").dataTable({
    "sDom": "<'row-fluid'<f>r>t<'row-fluid'<l><p>>",
    "sPaginationType": "bootstrap",
    "iDisplayLength": 10,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $("#therapist-table").data("source"),
    "aaSorting": [[ 1, "desc" ]],
    "aoColumns": [
                   null,
                   null,
                   null,
                   { "bSortable": false, "sWidth": "11%" }
                 ]
  });
}

function initializeButtons() {
  $(".add-dialog").live("click", function() {
    ajaxManager('get', '/therapists/add');
  });

  $("a.edit-btn").live("click", function() {
    var me = $(this);
    ajaxManager('get', '/therapists/'+me.attr('c_id')+'/edit');
  });
  
  $("#edit-therapist-form, #new-therapist").live('submit', function(e) {
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
    
    if(flag) {
      console.log(me.attr('action'));
      ajaxManager("post", me.attr('action'), me.serialize());
    } else {
      parent.prepend(errorMaker("Please fill out all required data."));
    }
  });

  $("a.delete-btn").live('click', function() {
    var me = $(this);
    ajaxManager("delete", "/therapists/"+me.attr("c_id"), {});
  });
}

$(document).ready(function() {
  initializeDataTable();
  initializeButtons();
});
