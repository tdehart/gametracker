# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# Setup a content array for the tooltips

$("[tooltip]").each ->
  $(this).tooltip({
    title: $(this).attr('tooltip')
  })