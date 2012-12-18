// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
//= require jquery-ui
//= require jquery.tokeninput
//= require nicEdit
//= require domains
//= require jquery.timepicker

$(document).ready(function() {
    nav_menu()
    tab_menu()

    $(document).keyup(function(e) {
        if (e.keyCode == 27) {
            closePopup(300);
        }
    });

    $('.sarg_choose').change(function(){
        $(this).siblings('.testing_label').text(this.value || 'Nothing selected');
    });

    // nav menu list drop up/down
    $('li.nav-header').click(function(){
        var item = $(this).children('i')
        $(this).parent().children('li:not(:first)').toggle(500);
    });
});

function nav_menu(){
    var arr =  window.location.pathname.split("/");
    arr.shift();
    if(arr[arr.length-1] == ''){
        arr.pop();
    }
    $("ul.breadcrumb").html()
    $("ul.breadcrumb").append("<li><a href='/'>home</a><span class='divider'>/</span> </li>")
    if(arr[0] != ""){
        $.each(arr, function(k,v){
            var url_href = "/" +  arr.slice(0, k+1).join("/")
            $("ul.breadcrumb").append("<li><a href='"+url_href+"' >"+v+"</a><span class='divider'>/</span> </li>")
        });
    }
}

function tab_menu(){
    var tab = window.location.pathname.substr(1).split("/");
    $("#"+tab[1]+"_tab").addClass("active");
    if (!$(".active").length && tab[0] == 'admin'){
        $("#rooms_tab").addClass("active");
    } else if (!$(".active").length){
        $("#dashboard_tab").addClass("active");
    }
}

$.ajaxSetup({
    beforeSend: function(xhr) {
        xhr.setRequestHeader("Accept", "text/javascript");
    }
});

//$(function() {
//    var $input = $('.token-input-users');
//    $input.tokenInput('/events/search_users.json', {
//        tokenLimit: 1,
//        tokenValue: 'id_with_class_name'
//    });
//});

$("#SuperModalPopupDiv").live('mouseover focus',function(){
    $(".token-input-list").tokenInput("/admin/events.json", {
      crossDomain: false,
      preventDuplicates: true,
      prePopulate: $(".token-input-list").data("pre"),
      propertyToSearch: "name"
    }),
    $("#SuperModalPopupDiv").attr("id","SuperModalPopupDivOff");
    $('#repeat_events_select_repeat_events').live('change',function(){
      if ($(this).val() == "selected days"){
        $("#checkdays").show();
      }
      else {
        $("#checkdays").hide();
      }
    });
});

//checkdays

$('#sarg_search').live('keyup',function() {
    var value = $(this).val();
    if ($(this).val() == ""){
        $("#sarg_index").contents().find("tr").show();
    }
    else {
        $("#sarg_index").contents().find("tr").hide();
        $("#sarg_index").contents().find('*:contains('+value+')').each(function(){
            $(this).show();
        });
    }
  return false;
});


