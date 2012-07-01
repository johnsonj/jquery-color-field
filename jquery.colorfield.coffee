$ = jQuery
is_initialized = false
color_field_class = 'color-field'
color_field_selector = ".#{color_field_class}"
color_value_selector = '.color-field-value'

# TODO: Take this as an option
valid_colors = ['#7bd148', '#5484ed', '#a4bdfc', '#46d6db', '#7ae7bf', '#51b749', '#fbd75b', '#ffb878', '#ff887c', '#dc2127', '#dbadff', '#e1e1e1']

$.fn.extend \
  colorfield: ->
    unless is_initalized
      $(color_field_selector).live 'click', activate_picker
      $(color_field_selector).live 'blur', destroy_picker
      $(color_field_selector).each update_color
      is_initalized = true 
    
    this.each ->
      $this = $(this)
      data = $this.data('color-field')
      
      unless data?
        $this.data('color-field', true)
        $this.addClass(color_field_class, true)
        update_color.call($this)

activate_picker = ->
  $(@).after('<div id="color-picker-container" style=""></div>')
  $container = $('#color-picker-container')
  $action_field = $(@)
  $value_field = $(@).siblings(color_value_selector)
  old_color = $value_field.val()
  $.each valid_colors, (i, color) ->
    $container.append "<div class='color-picker-choice' style='background-color: #{color}'>&nbsp;</div>"
  $('.color-picker-choice').hover \
    -> 
      new_color = $(this).css('background-color')
      $value_field.val(new_color)
      update_color.call($action_field)
    ,
    -> apply_color.call($action_field, old_color)
    
apply_color = (color) ->
  $(this).css 'background', color

update_color = () ->
  apply_color.call this, $(this).siblings(color_value_selector).val()

destroy_picker = ->
  $('#color-picker-container').remove()