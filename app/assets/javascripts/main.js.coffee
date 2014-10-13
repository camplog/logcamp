$ ->
  flashCallback = ->
    $(".pure-alert").fadeOut()
  $(".pure-alert").bind 'click', (ev) =>
    $(".pure-alert").fadeOut()
  setTimeout flashCallback, 3000