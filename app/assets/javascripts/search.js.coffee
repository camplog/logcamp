$ ->
  $("#save-search-link").click (event) ->
    criteria = $("#query").val()
    updateSearchUrl = $("#update_search_url").val()

    $.ajax
      url: updateSearchUrl
      type: 'PUT'
      dataType: 'JSON'
      data:
        "search[criteria]": criteria