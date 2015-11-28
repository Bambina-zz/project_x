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

$(document).on 'ajax:success', '#new_errand', ->
  $('#errand_name').val ''
　.on 'ajax:error', (event, data) ->
    response = JSON.parse(data.responseText)
    if response['method'] == 'create' && response['errand']
      nameError = response['errand']['name']
      $('#new_errand .name_error').html(nameError)

$(document).on 'ajax:error', '.update_errand', (event, data) ->
  element = event.target
  id = $(element).data('id')
  response = JSON.parse(data.responseText)
  if response['method'] == 'update' && response['errand']
    nameError = response['errand']['name']
    $("#edit_errand_#{id} .name_error").html(nameError)

$(document).on 'click', '#copy_to_clipboard', (event) ->
  $('.shared_url').select()
  document.execCommand('copy')
