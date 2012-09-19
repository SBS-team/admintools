$(document).ready ->
  $(".datepicker").datepicker
    dateFormat: "yy-mm-dd"
    firstDay: 1
    showOtherMonths: true
    selectOtherMonths: true
  $("#ui-datepicker-div").hide()

  $(".datepicker-from").datepicker
    dateFormat: "yy-mm-dd"
    firstDay: 1
    changeYear: true
    changeMonth: true
    showOtherMonths: true
    selectOtherMonths: true
    showButtonPanel: true
    onSelect: (selectedDate) ->
      $(".datepicker-to").datepicker "option", "minDate", selectedDate
      $(".from").attr "value", selectedDate

  $(".datepicker-to").datepicker
    dateFormat: "yy-mm-dd"
    firstDay: 1
    changeYear: true
    changeMonth: true
    showOtherMonths: true
    selectOtherMonths: true
    showButtonPanel: true
    onSelect: (selectedDate) ->
      $(".datepicker-from").datepicker "option", "maxDate", selectedDate
      $(".to").attr "value", selectedDate

  $("#clear-to").on 'click', (e) ->
    $(".datepicker-to").attr "value", ""
    $(".datepicker-from").datepicker "option",
      minDate: null
      maxDate: null
    $(".to").attr "value", ""

  $("#clear-from").on 'click', (e) ->
    $(".datepicker-from").attr "value", ""
    $(".datepicker-to").datepicker "option",
      minDate: null
      maxDate: null
    $(".from").attr "value", ""