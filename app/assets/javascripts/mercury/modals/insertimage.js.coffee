@Mercury.modalHandlers.insertImage = {

  initialize: ->
    @element.find('.control-label input').on('click', @onLabelChecked)
    @element.find('.controls .optional, .controls .required').on('focus', (event) => @onInputFocused($(event.target)))

    @focus('#image_url')
    @initializeForm()

    # build the image or embed/iframe on form submission
    @element.find('form').on 'submit', (event) =>
      event.preventDefault()
      @validateForm()
      unless @valid
        @resize()
        return
      @submitForm()
      @hide()


  initializeForm: ->
    # get the selection and initialize its information into the form
    return unless Mercury.region && Mercury.region.selection
    selection = Mercury.region.selection()

    # if we're editing an image prefill the information
    if image = selection.is?('img')
      @element.find('#image_url').val(image.attr('src'))
      @element.find('#image_alignment').val(image.attr('align'))
      @element.find('#image_float').val(if image.attr('style')? then image.css('float') else '')
      @focus('#image_url')

  focus: (selector) ->
    setTimeout((=> @element.find(selector).focus()), 300)


  onLabelChecked: ->
    forInput = jQuery(@).closest('.control-label').attr('for')
    jQuery(@).closest('.control-group').find("##{forInput}").focus()


  onInputFocused: (input) ->
    input.closest('.control-group').find('input[type=radio]').prop('checked', true)

    return if input.closest('.image-options').length
    @element.find(".image-options").hide()
    @element.find("##{input.attr('id')}_options").show()
    @resize(true)


  addInputError: (input, message) ->
    input.after('<span class="help-inline error-message">' + Mercury.I18n(message) + '</span>').closest('.control-group').addClass('error')
    @valid = false


  clearInputErrors: ->
    @element.find('.control-group.error').removeClass('error').find('.error-message').remove()
    @valid = true


  validateForm: ->
    @clearInputErrors()
    el = @element.find("#image_url")
    @addInputError(el, "can't be blank") unless el.val()


  submitForm: ->
    attrs = {src: @element.find('#image_url').val()}
    attrs['align'] = alignment if alignment = @element.find('#image_alignment').val()
    attrs['style'] = 'float: ' + float + ';' if float = @element.find('#image_float').val()
    Mercury.trigger('action', {action: 'insertImage', value: attrs})
}
