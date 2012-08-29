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



$(document).ready(function() {
    nav_menu()
    tab_menu()
});

function nav_menu(){
    var arr =  window.location.pathname.split("/");
    arr.shift();
    $("ul.breadcrumb").html()
    $("ul.breadcrumb").append("<li><a href='/'>home</a><span class='divider'>/</span> </li>")
    if(arr[0] != ""){
        $.each(arr, function(k,v){
            var url_href= arr.slice(0, k+1).join("/")
            $("ul.breadcrumb").append("<li><a href='"+url_href+"' >"+v+"</a><span class='divider'>/</span> </li>")
        });
    }
}
function tab_menu(){
    var tab = window.location.pathname.substr(1).split("/");
    $("#"+tab[0]+"_tab").addClass("active");
    if (!$(".active").length){
        $("#rooms_tab").addClass("active");
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
$("#token-input-list").live('focus',function() {
    $(".token-input-list").tokenInput("/events.json", {
      crossDomain: false,
      prePopulate: $(".token-input-list").data("pre"),
      propertyToSearch: "name"
    }),
    $(".token-input-list").attr("id","new-token-input-list");
});
