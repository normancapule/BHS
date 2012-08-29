$(document).ready(function() {
  $("#home-reservation").dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "iDisplayLength": 10
  });
  
  $('.new_reservation #reservation_number_people').live("keyup", function(e){
    this.value = this.value.replace(/[^0-9\.]/g,'');
  });

  $(".new_reservation").submit(function(e) {
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
      $.ajax({
        type: 'post',
        url: $(this).attr('action'),
        data: $(this).serialize(),
        datatype: 'json',
        success: function() {
        },
        errors: function() {
        },
      });    
    } else {
      parent.prepend("<div class='alert alert-error reservation-errors'>"+
                    "<button type='button' class='close' data-dismiss='alert'>×</button>"+
                    "Please fill out all required data."+
                    "</div>");
    }
  });
  
  $("#add-reservation").dialog({
    title: "Add a Reservation",
    autoOpen: true,
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
  
  $("#edit-reservation").dialog({
    autoOpen: false,
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
});
