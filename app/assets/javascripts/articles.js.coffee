# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.toggle = (id) ->
  tag = "#button-" + id
  value = $(tag).attr('value')
  if value is 'Like'
    value = 'Unlike'
  else
    value = 'Like'
  $(tag).attr('value', value)
