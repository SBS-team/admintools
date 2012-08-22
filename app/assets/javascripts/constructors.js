var revertGlobal = true;
var roomId = $(".room").attr("id").split("_")[1]

var dropWorkplaceOpt = {
  drop: function(event, ui){
    if(ui.draggable.hasClass("desktop")){ 
      // check for desktop
      // if add new desktop, old desktop will deleted from workplace
      if($(this).children().length > 0){
        $(this).children().detach().appendTo("#desktops")
        relateDesktopToWorkplace($(this).attr("id").split("_")[1], 'nil')
      }
      // clear old workplace
      if($("#"+ui.draggable.attr("id")).parent().hasClass("table")){
        relateDesktopToWorkplace($("#"+ui.draggable.attr("id")).parent().attr('id').split("_")[1], 'nil')  
      }
      // relate desktop with workplace from desktops area
      $("#"+ui.draggable.attr('id')).detach().appendTo("#"+$(this).attr('id')).css({'top':'0', 'left':'0'})
      relateDesktopToWorkplace($(this).attr('id').split("_")[1], ui.draggable.attr('id').split("_")[1])
    }
  }
}

var dragOpt = {
  grid:          [5, 5],
  containment:   "#schema-wrapper",
  snap:          ".room",
  snapTolerance: 15,
  revert: function(droppableObj){
    if(droppableObj === false){
      revertGlobal = true
      return false
    }else{
      revertGlobal = false
      return true
    }
  }, 
  stack:         ".room div",
  stop: function(event, ui){
    var workplace_id = $(this).attr("id").split("_")[1]
    if(revertGlobal){
      updateWorkplace(workplace_id, ui.position)
    }
    if($(this).hasClass("new-table")){
      $(this).removeClass("new-table")
    }
  }
};

function createWorkplace(type, form){
  $.post(
      "/constructors", 
      {
        "_method": "post",
        "workplace": {
        "workplace_type": type,
        "workplace_form": form,
        "top"           : "0",
        "left"          : "0",
        "room_plan_id"  : roomId
        }
      },
      function(res){
        if(res.status > 0){
          $("<div />").attr("id", "workplace_"+res.workplace.id).addClass("table new-table").addClass(type).addClass(form).appendTo(".room").draggable(dragOpt).droppable(dropWorkplaceOpt);
        } else {
          // console.log('create', "error")
        }
      },
      "json"
  )
}

function updateWorkplace(id, position){
  $.post(
    "/constructors/"+id,
    { 
      "_method": "put",
      "workplace": {
        "top"  : position.top,
        "left" : position.left
      }
    },
    function(res, status){
      console.log(res, status)
      if(res && res.status > 0){
        $(".alerts").after(
          $("<div />").hide().addClass("alert alert-success alert-workplace").html("Данные обновлены").fadeIn("fast").delay(1000).fadeOut("fast", function(){
              $(".alert-success.alert-workplace").remove()
          })
        )
      
      }
    },
    "json"
  )
}

function destroyWorkplace(id){
  $.post(
    "/constructors/"+id,
    {"_method": "delete"},
    function(res){
      if(res){}
        // console.log("destroy", res)
    },
    "json"
  )
}

function relateDesktopToWorkplace(workplace, desktop){
    $.post(
    "/constructors/"+workplace,
    {
      "_method": "put",
      "workplace": {
        "desktop_id": desktop
      }
    }
    
  )
}

$(document).ready(function() {

  $(".table").draggable(dragOpt).droppable(dropWorkplaceOpt)

  $("#desktops").droppable({
    drop: function(event, ui){
      if($("#"+ui.draggable.attr("id")).parent().hasClass("table")){
        var workplace = $("#"+ui.draggable.attr("id")).parent().attr("id").split("_")[1]
        $("#"+ui.draggable.attr('id')).css({'top':'0', 'left':'0'}).detach().appendTo("#desktops")
        relateDesktopToWorkplace(workplace, '')
      }
    }
  });

  $('#trash').droppable({
    drop: function(event, ui){
      var workplace_id = ui.draggable.attr("id").split("_")[1]
      if(confirm('Remove?')){
        destroyWorkplace(workplace_id)
        
        if( $("#"+ui.draggable.attr("id")).children().hasClass("desktop") ){

          $("#"+ui.draggable.attr('id')).children().css({'top':'0', 'left':'0'}).detach().appendTo("#desktops")

        }

        ui.draggable.fadeOut('1000', function(){ui.draggable.remove()})
      }
    }
  })

  $(".table").live("dblclick",function(){
    $('#modalDesktops').modal('show')
  });

  // table generator
  // line table
  $('.addLine').bind('click', function(event){
    event.preventDefault();
    createWorkplace("line", $(this).attr('id'))
  });
  // angle table
  $('.addAngle').bind('click', function(event){
    event.preventDefault();
    createWorkplace("angl", $(this).attr('id'))
  });

  $(".desktop").draggable({revert: true})
});