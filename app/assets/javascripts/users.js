function set_daily_value(daily){
  var from = $(daily).next();
  var to = $(from).next();
  $(daily).attr('value', from.val() + '-' + to.val());
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
  $('.daily-from').timepicker({
    onClose: function(time){
      set_daily_value($(this).data('parent'))
    }
  })
  $('.daily-to').timepicker({
    onClose: function(time){
      set_daily_value($(this).data('parent'))
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