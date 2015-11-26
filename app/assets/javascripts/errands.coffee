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

$(document).on 'ajax:success', '#new_errand', (event) ->
  $('#errand_name').val ''
　.on 'ajax:error', '#new_errand', (event, data) ->
  errors = JSON.parse(data.responseText)
  nameError = errors['name']
  $('#create_name_error').html(nameError)

$(document).on 'click', '#copy_to_clipboard', (event) ->
  $('.shared_url').select()
  document.execCommand('copy')
