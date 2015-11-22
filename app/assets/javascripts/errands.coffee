# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'click', '.edit_errand', (event) ->
  element = event.target
  id = $(element).data('id')

  $("#edit_errand_#{id}").removeClass('hidden')
  $("#errand_#{id} .link_to_errand").addClass('hidden')
  $("#errand_#{id} .edit_errand").addClass('hidden')
  $("#errand_#{id} .edit_errand_cancel").removeClass('hidden')


$(document).on 'click', '.edit_errand_cancel', (event) ->
  element = event.target
  id = $(element).data('id')

  $("#edit_errand_#{id}").addClass('hidden')
  $("#errand_#{id} .link_to_errand").removeClass('hidden')
  $("#errand_#{id} .edit_errand").removeClass('hidden')
  $("#errand_#{id} .edit_errand_cancel").addClass('hidden')
