$ ->
  $(document).on "click", "#save-search-link", (event) ->
    criteria = $("#query").val()
    updateSearchUrl = $("#update_search_url").val()

    isUpdating = true

    if updateSearchUrl == undefined
      updateSearchUrl = "/searches"
      type = "POST"
      dataType = "script"
      isUpdating = false
    else
      type = "PUT"
      dataType = "JSON"

    $.ajax
      url: updateSearchUrl
      type: type
      dataType: dataType
      data:
        "search[criteria]": criteria