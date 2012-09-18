$(document).ready(function() {
  $("#user_account_birthday").datepicker({
    changeYear: true,
    maxDate: new Date,
    yearRange: '-90:+0',
    dateFormat: 'yy-mm-dd'
  });
});
