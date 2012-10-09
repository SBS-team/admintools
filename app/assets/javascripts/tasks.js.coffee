$("#start_scheduler").on "click", (e) ->
  e.preventDefault()
  $.post "/tasks/scheduler",
    _method: "put"
  , ((res, status) ->
    if res.status > 0
      console.log res, status
  ), "json"
  $(".scheduler-stop").fadeOut "1000", (e) ->
    $(".scheduler-run").fadeIn "1000"

$("#stop_scheduler").on "click", (e) ->
  e.preventDefault()
  $.post "/tasks/scheduler",
    _method: "delete"
  , ((res, status) ->
    if res.status > 0
      console.log res, status
  ), "json"
  $(".scheduler-run").fadeOut "1000", (e) ->
    $(".scheduler-stop").fadeIn "1000"

$("#start_workers").on "click", (e) ->
  e.preventDefault()
  $.post "/tasks/workers",
    _method: "put"
  , ((res, status) ->
    if res.status > 0
      console.log res, status
  ), "json"
  $(".workers-stop").fadeOut "1000", (e) ->
    $(".workers-run").fadeIn "1000"

$("#stop_workers").on "click", (e) ->
  e.preventDefault()
  $.post "/tasks/workers",
    _method: "delete"
  , ((res, status) ->
    if res.status > 0
      console.log res, status
  ), "json"
  $(".workers-run").fadeOut "1000", (e) ->
    $(".workers-stop").fadeIn "1000"