$(document).on 'click', '#menu-toggle', (event) ->
  event.preventDefault()
  $("#wrapper").toggleClass("toggled")
