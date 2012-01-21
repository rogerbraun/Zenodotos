//= require active_admin/base
//= require jquery-ui-1.8.17.custom.min

$(function() {
  $("#book_aufnahmedatum").datepicker({dateFormat: 'yy-mm-dd'});
  $("#lending_return_date").datepicker({dateFormat: 'yy-mm-dd'});
});
