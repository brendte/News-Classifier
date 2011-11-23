# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.toggle = (id) ->
  tag = "#button-" + id
  value = $(tag).attr('value')
  if value is 'Like'
    value = 'Unlike'
    button = "nice small radius blue button"
  else
    value = 'Like'
    button = "nice small radius red button"
  $(tag).attr('value', value)
  $(tag).attr('class', button)
