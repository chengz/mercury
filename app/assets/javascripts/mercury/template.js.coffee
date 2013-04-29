class @Mercury.Template


  @display: (name) ->
    template = Mercury.Template.create(name)
    Mercury.trigger('action', {action: 'insertTemplate', value: template})
    Mercury.template = null


  @create: (name) ->
    return new Mercury.Template(name)

  @previewUrl: (name) ->
    url = Mercury.config.templates.previewUrl
    url = url() if typeof(url) == 'function'
    return url.replace(':name', name)


  constructor: (@name) ->
    @data = ''

  getHTML: (context) ->
    element = jQuery("<div>", {
      class: "#{@name}-template template-section"
      'data-template': @name
    }, context)
    jQuery.ajax Template.previewUrl(@name), {
      headers: Mercury.ajaxHeaders()
      type: Mercury.config.templates.method
      data: {}
      success: (data) =>
        @data = data
        element.html(data)
      error: =>
        Mercury.notify('Error loading the preview for the \"%s\" template.', @name)
    }
    return element

