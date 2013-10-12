# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#story_output_language_tokens').tokenInput '/users/languages.json',
    theme: 'facebook'
    prePopulate: $('#story_output_language_tokens').data('load')