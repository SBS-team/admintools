function set_daily_value(type, time){
  var times = $('#user_daily').attr('value').split('-')
  if(type == 'from'){
    times[0] = time
  }
  if(type == 'to'){
    times[1] = time
  }
  $('#user_daily').attr('value', times.join('-'))
  console.log($('#user_daily').attr('value'))
}
function init_daily_times(){
  var times = $('#user_daily').attr('value').split('-')
  $('#daily-from').attr('value',times[0])
  $('#daily-to').attr('value',times[1])
}
$(document).ready(function(){
  if($('#user_daily').length > 0){
    init_daily_times()
  }
  $('#user_birthday').datepicker({
    'dateFormat': "yy-mm-dd",
    'changeYear': true,
    'changeMonth': true,
    'yearRange': "c-50:c+10"
  });
  $('#daily-from').timepicker({
    onClose: function(time){
      set_daily_value('from', time)
    }
  })
  $('#daily-to').timepicker({
    onClose: function(time){
      set_daily_value('to', time)
    }
  })
  $("#deleted_users").on("click", function(event){
    $(".users_real").hide();
      $(".users_deleted").show();
  });
  $("#real_users").on("click", function(event){
    $(".users_deleted").show();
    $(".users_real").hide();
  });
});