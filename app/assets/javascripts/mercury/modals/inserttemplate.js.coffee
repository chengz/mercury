@Mercury.modalHandlers.insertTemplate = ->
  event.preventDefault()
  template = Mercury.Template.create(@options.templateName)
  Mercury.trigger('action', {action: 'insertTemplate', value: template})
  @hide()

