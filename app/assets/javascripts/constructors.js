var revertGlobal = true;
var roomId = $(".room").attr("id").split("_")[1]

var dragOpt = {
  grid:          [5, 5],
  containment:   "#schema-wrapper",
  snap:          ".room",
  snapTolerance: 15,
  revert: function(droppableObj){
     if(droppableObj === false){
        revertGlobal = true;
        return false;
     }else{
        revertGlobal = false;
        return true;
     }
  }, 
  stack:         ".room div",
  stop: function(event, ui){
    var workplace_id = $(this).attr("id").split("_")[1]
    
    if(revertGlobal){
      console.log('update position')
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
      {"workplace": {
        "workplace_type": type,
        "workplace_form": form,
        "top"           : "0",
        "left"          : "0",
        "room_plan_id"  : roomId
        }
      },
      function(res){
        if(res){
          $("<div />").attr("id", "workplace_"+res.id).addClass("table new-table").addClass(type).addClass(form).appendTo(".room").draggable(dragOpt);
          // console.log('create', res)
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
    function(res){
      if(res){
        // console.log("update", res)
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

$(document).ready(function() {

  $(".table").draggable(dragOpt);

  $('#trash').droppable({
    drop: function(event, ui){
      var workplace_id = ui.draggable.attr("id").split("_")[1]
      if(confirm('Remove?')){
        destroyWorkplace(workplace_id)
        ui.draggable.fadeOut('1000', function(){ui.draggable.remove()})
      }
    }
  })

  $(".table").live("dblclick",function(){
    console.log("DOUBLE click")
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

});