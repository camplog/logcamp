$ ->
  flashCallback = ->
    $(".pure-alert-removable").fadeOut()
  $(".pure-alert-removable").bind 'click', (ev) =>
    $(".pure-alert-removable").fadeOut()
  setTimeout flashCallback, 3000