@Mercury.dialogHandlers.templatePanel = ->
  # make the filter work
  @element.find('input.filter').on 'keyup', =>
    value = @element.find('input.filter').val()
    for template in @element.find('li[data-filter]')
      if LiquidMetal.score(jQuery(template).data('filter'), value) == 0 then jQuery(template).hide() else jQuery(template).show()

  # when an element is dragged, set it so we have a global object
  @element.find('img[data-template]').on 'dragstart', ->
    Mercury.template = {name: jQuery(@).data('template')}
