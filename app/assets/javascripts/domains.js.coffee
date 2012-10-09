# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.sendBoolian = (elem, domain_id) ->
  $.post "/admin/domains/" + domain_id,
    _method: "put"
    domain:
      check: $(elem).is(":checked")
      active: -1