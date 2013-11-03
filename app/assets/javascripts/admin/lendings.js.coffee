# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).on('confirm:complete', (e,answer) ->
  if ($(':checked').length == 0)
    alert("Bitte zuerst die Bücher auswählen, die zurückgegeben oder verlängert werden sollen!")
)
