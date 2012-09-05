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
//= require jquery.metadata
//= require jquery.tablesorter

$(document).ready(function() {
    nav_menu()
    tab_menu()

    $(document).keyup(function(e) {
        if (e.keyCode == 27) {
            closePopup(300);
        }
    });


});

$.tablesorter.addParser({
    // set a unique id
    id: 'bytes',
    is: function(s) {
        // return false so this parser is not auto detected
        return false;
    },
    format: function(s) {
        // format your data for normalization
        var weight, val;
        switch(s.toLowerCase()[s.length - 1]) {
            case 'е': weight = 1024; val = parseFloat(s.substring(0, s.length - 1)); break;
            case 'm': weight = Math.pow(1024,2); val = parseFloat(s.substring(0, s.length - 1)); break;
            case 'g': weight = Math.pow(1024,3); val = parseFloat(s.substring(0, s.length - 1)); break;
            case 't': weight = Math.pow(1024,4); val = parseFloat(s.substring(0, s.length - 1)); break;
            default : weight = 1; val = parseFloat(s); break;
        };
        return val * weight;
    },
    // set type, either numeric or text
    type: 'numeric'
});


function sarg_sort(current){
    var iframe = current.contents()
    iframe.find("table").addClass("tablesorter");
    iframe.contents().find(".logo, .title, .index table tr:lt(2)").remove();
    iframe.find("table").prepend('<thead><tr><th class="header_l">FILE/PERIOD</th><th class="header_l">CREATION DATE</th><th class="header_l">USERS</th><th class="header_l">BYTES</th><th class="header_l">AVERAGE</th></tr></thead>');
    $.tablesorter.defaults.sortList = [[2,1],[3,1],[4,1]];
    iframe.find("table").tablesorter({headers: { 3: {sorter:'bytes'}, 4: {sorter:'bytes'} } });
};

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
$("#SuperModalPopupDiv").live('mouseover focus',function(){
    $(".token-input-list").tokenInput("/events.json", {
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
