var revertGlobal = true;
var roomId
var checkRoom = $(".room").length
if(checkRoom > 0){
  roomId = $(".room").attr("id").split("_")[1]
}

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
      if($("#"+ui.draggable.attr("id")).parent().hasClass("workplace")){
        relateDesktopToWorkplace($("#"+ui.draggable.attr("id")).parent().attr('id').split("_")[1], 'nil')
      }
      // relate desktop with workplace from desktops area
      $("#"+ui.draggable.attr('id')).detach().appendTo("#"+$(this).attr('id')).css({'top':'0', 'left':'0'})
      relateDesktopToWorkplace($(this).attr('id').split("_")[1], ui.draggable.attr('id').split("_")[1])
    }
  }
}

function isWorkplace(obj){
  if($(obj).hasClass('line') || $(obj).hasClass('angl'))
    return true
  else
    return false
}

var dragOpt = {
  grid: [5, 5],
  containment:   "#schema-wrapper",
  snap:          ".room",
  snapMode:      "inner",
  snapTolerance: 10,
  revert: function(droppableObj){
    var draggableObj = $(this)
    if($(droppableObj).attr('id') == 'trash'){
      revertGlobal = false
      return true
    }else if(isWorkplace(draggableObj) && isWorkplace(droppableObj)){
      revertGlobal = false
      return true
    }else{
      revertGlobal = true
      return false
    }
  },
  stack:         ".room div",
  stop: function(event, ui){
    // fix snap position
    if(ui.position.top % 5)
      $(this).css('top', ui.position.top > 0 ? ui.position.top - 1 : ui.position.top + 1)
    if(ui.position.left % 5)
      $(this).css('left', ui.position.left > 0 ? ui.position.left - 1 : ui.position.left + 1)

    var workplace_id = $(this).attr("id").split("_")[1]
    if(revertGlobal){
      updateWorkplace(workplace_id, ui.position)
    }
    if($(this).hasClass("new-table")){
      $(this).removeClass("new-table")
    }
  }
};

function createWorkplace(type, form, title){
  var reqData = {
        "_method": "post",
        "workplace": {
        "workplace_type": type,
        "workplace_form": form,
        "top"           : "0",
        "left"          : "0",
        "room_plan_id"  : roomId
        }
      };
  if(title)
    reqData["workplace"]["title"] = title
  $.post(
      "/admin/constructors",
      reqData,
      function(res, status){
        if(res.status > 0){
          var el = $("<div />").attr("id", "workplace_"+res.workplace.id).addClass("workplace new-table").addClass(type).addClass(form).appendTo(".room").draggable(dragOpt).droppable(dropWorkplaceOpt);
          if(title)
            el.attr("title", title)
        }
      },
      "json"
  )
}

function updateWorkplace(id, position){
  $.post(
    "/admin/constructors/"+id,
    {
      "_method": "put",
      "workplace": {
        "top"  : position.top,
        "left" : position.left
      }
    }
  )
}

function destroyWorkplace(id){
  $.post(
    "/admin/constructors/"+id,
    {"_method": "delete"}
  )
}

function relateDesktopToWorkplace(workplace, desktop){
    $.post(
    "/admin/constructors/"+workplace,
    {
      "_method": "put",
      "workplace": {
        "desktop_id": desktop
      }
    }
  )
}

$(document).ready(function() {

  $(".workplace").draggable(dragOpt)
  $(".workplace.line, .workplace.angl").droppable(dropWorkplaceOpt)

  $("#desktops").droppable({
    drop: function(event, ui){
      if($("#"+ui.draggable.attr("id")).parent().hasClass("workplace")){
        var workplace = $("#"+ui.draggable.attr("id")).parent().attr("id").split("_")[1]
        $("#"+ui.draggable.attr('id')).css({'top':'0', 'left':'0'}).detach().appendTo("#desktops")
        relateDesktopToWorkplace(workplace, '')
      }
    }
  });

  $('#trash').droppable({
    drop: function(event, ui){
      var workplace_id = ui.draggable.attr("id").split("_")[1]
      if(confirm('Удалить?')){
        destroyWorkplace(workplace_id)
        if( $("#"+ui.draggable.attr("id")).children().hasClass("desktop") ){
          $("#"+ui.draggable.attr('id')).children().css({'top':'0', 'left':'0'}).detach().appendTo("#desktops")
        }
        ui.draggable.fadeOut('1000', function(){ui.draggable.remove()})
      }
    }
  })

  $(".desktop").draggable({revert: true})

  $(".desktop").bind("click", function(event){
    event.preventDefault();
  })
  $(".desktop").bind("mousedown", function(event){
    event.preventDefault();
    $(this).css('z-index', '100000')
  })
  $(".desktop").bind("mouseup", function(event){
    event.preventDefault();
    $(this).css('z-index', 'auto')
  })
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

  // office devices generator
  $('.addOfficeDevice').bind('click', function(event){
    event.preventDefault();
    createWorkplace("office-device", $(this).attr('id'), $(this).attr('id').split("-")[1])
  })

});