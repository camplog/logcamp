ready = ->

  flashCallback = ->
    $(".pure-alert-removable").fadeOut()
  $(".pure-alert-removable").bind 'click', (ev) =>
    $(".pure-alert-removable").fadeOut()
  setTimeout flashCallback, 3000

  $(document).on "click", ".event", (event) ->
  	$(this).find(".metadata").toggle()

$(document).ready(ready)
$(document).on('page:load', ready)
window.ready = ready