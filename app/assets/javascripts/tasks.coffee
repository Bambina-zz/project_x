$(document).on 'click', '.edit_task', (event) ->
  element = event.target
  id = $(element).data('id')
  errandId = $(element).data('errandId')

  $("#tasks_errand_#{errandId} #edit_task_#{id}").removeClass('hidden')
  $("#tasks_errand_#{errandId} #task_#{id} .name_task").addClass('hidden')
  $("#tasks_errand_#{errandId} #task_#{id} .edit_task").addClass('hidden')
  $("#tasks_errand_#{errandId} #task_#{id} .edit_task_cancel").removeClass('hidden')

$(document).on 'click', '.edit_task_cancel', (event) ->
  element = event.target
  id = $(element).data('id')
  errandId = $(element).data('errandId')

  $("#tasks_errand_#{errandId} #edit_task_#{id}").addClass('hidden')
  $("#tasks_errand_#{errandId} #task_#{id} .name_task").removeClass('hidden')
  $("#tasks_errand_#{errandId} #task_#{id} .edit_task").removeClass('hidden')
  $("#tasks_errand_#{errandId} #task_#{id} .edit_task_cancel").addClass('hidden')

$(document).on 'ajax:success', '#new_task', (event) ->
  $('#task_name').val ''
　.on 'ajax:error', (event, data) ->
  errors = JSON.parse(data.responseText)
  if errors['task']
    nameError = errors['task']['name']
    $('#new_task .name_error').html(nameError)

$(document).on 'click', '.checkbox_done', (event)->
  element = event.target
  id = $(element).data('id')
  $("#task_#{id} #edit_done").submit()
