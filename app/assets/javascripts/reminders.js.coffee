# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(() ->
  $(".boxes_selector").on("click", (ev) ->
    if $(this).data("state") == "all"
      $(this).parent().find(":checkbox").attr("checked", true)
      $(this).data("state", "none")
    else
      $(this).parent().find(":checkbox").attr("checked", false)
      $(this).data("state", "all")
    false
  )

  $(".alert").alert()
)
