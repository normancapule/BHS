function errorMaker(message) {
  return "<div class='alert alert-error reservation-errors'>"+
           "<button type='button' class='close' data-dismiss='alert'>×</button>"+
           message +
         "</div>";
}

function initializeDataTable() {
  $("#home-reservation").dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<l><p>>",
    "sPaginationType": "bootstrap",
    "iDisplayLength": 10,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $("#home-reservation").data("source"),
    "aaSorting": [[ 2, "desc" ]],
    "aoColumns": [
                   null,
                   { "sWidth": "20%" },
                   { "sWidth": "11%" },
                   { "bSortable": false, "sWidth": "11%" }
                 ],
  });
}

function initializeEditDialog() {
  $("#edit-reservation").dialog({
    title: "Edit a Reservation",
    autoOpen: true,
    width: 'auto',
    height: '300',
    modal: true,
    resizable: false,
    buttons: {
      "Edit": function() {
        $(".edit_reservation").submit()
      },
      "Close": function() {
        $(this).dialog("close");
      }
    }
  });
}

function initializeAddDialog() {
  $("#add-reservation").dialog({
    title: "Add a Reservation",
    autoOpen: false,
    width: 'auto',
    height: '300',
    modal: true,
    resizable: false,
    buttons: {
      "Add": function() {
        $(".new_reservation").submit()
      },
      "Close": function() {
        $(this).dialog("close");
      }
    }
  });
}

function initializeButtons() {
  $('.new_reservation #reservation_number_people').live("keyup", function(e){
    this.value = this.value.replace(/[^0-9\.]/g,'');
  });

  $(".add-dialog").live("click", function() {
    $("#add-reservation").dialog("open"); 
  });
  
  $(".edit-btn").live("click", function() {
    $(".load-indicator").fadeIn();
    $.ajax({
      type: 'post',
      url: '/pages/edit_reservation/',
      data: {"id": $(this).attr("r_id")},
      datatype: 'json',
      success: function() {
        $(".load-indicator").fadeOut();
      }
    });
  });
  
  $(".delete-btn").live("click", function(){
    $(".load-indicator").fadeIn();
    $.ajax({
      type: 'delete',
      url: '/pages/delete_reservation/',
      data: {"id": $(this).attr("r_id")},
      datatype: 'json',
      success: function() {
        $(".load-indicator").fadeOut();
      }
    });
  });

  $(".edit_reservation, .new_reservation").live('submit', function(e) {
    e.preventDefault();
    var flag = true,
        parent = $(this).parent();
    if(parent.find("#reservation_name").val().length == 0) {
      flag = false;
    }
    
    if(parent.find("#reservation_number_people").val().length == 0 || 
       parent.find("#reservation_number_people").val() == 0) {
      flag = false;
    }
    
    if(flag) {
      $(".load-indicator").fadeIn();
      $.ajax({
        type: 'post',
        url: $(this).attr('action'),
        data: $(this).serialize(),
        datatype: 'json',
        success: function() {
          $("#add-reservation").dialog("close");
          $("#edit-reservation").dialog("close");
          $(".load-indicator").fadeOut();
        },
        errors: function() {
          parent.prepend(errorMaker("Please fill out all required data."));
          $(".load-indicator").fadeOut();
        },
      });    
    } else {
      parent.prepend(errorMaker("Please fill out all required data."));
    }
  });
}

$(document).ready(function() {
  initializeDataTable();
  initializeAddDialog();
  initializeButtons();
});
