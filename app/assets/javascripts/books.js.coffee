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

  $("#next_free_signature, #fill_in_with_google").popover()

  $("#next_free_signature").click(() ->
    signature = $("#book_signatur").val()
    free = $.getJSON(
      "/admin/books/next_free_signature",
      {signature: signature},
      (json) ->
        $("#book_signatur").val(signature + json["next_free_signature"])
    )
  )

  $("#fill_in_with_google").click(() ->
    title = $("#book_titel").val()
    isbn =  $("#book_isbn").val()
    query = isbn || title
    $.getJSON(
      "https://www.googleapis.com/books/v1/volumes?callback=?",
      {"q": query},
      (json) ->
        document.temp_json = json
        guess = json.items[0].volumeInfo
        authors = guess.authors.join("; ")
        $('#book_titel').val(guess.title)
        $("#book_autor").val(guess.authors.join("; "))
        $("#book_verlag").val(guess.publisher)
        $("#book_seiten").val(guess.pageCount)
        $("#book_sprache").val(guess.language)
        $("#book_inhalt").val(guess.description)
        isbns = []
        $.each(guess.industryIdentifiers, (index, isbn) ->
          isbns.push(isbn.identifier)
        )
        $("#book_isbn").val(isbns.join(" / "))
    )
  )

)


