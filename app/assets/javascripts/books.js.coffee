# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$( () ->

  # Datepickers
  $("#book_aufnahmedatum").datepicker({dateFormat: 'yy-mm-dd'})
  $("#lending_return_date").datepicker({dateFormat: 'yy-mm-dd'})
  $("input.date").datepicker({dateFormat: 'yy-mm-dd'})

  # Popovers

  $("td.actions a").popover
    placement: "left"
    delay:
      show: 500
      hide: 100
)


