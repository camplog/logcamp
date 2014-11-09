$ ->
  $(document).on "click", "#save-search-link", (event) ->
    criteria = $("#query").val()
    updateSearchUrl = $("#update_search_url").val()

    $.ajax
      url: updateSearchUrl
      type: 'PUT'
      dataType: 'JSON'
      data:
        "search[criteria]": criteria
      success:
        window.location.reload()