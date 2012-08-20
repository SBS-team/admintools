$(document).ready(function() {
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $('#calendar').fullCalendar({
        theme: true,
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        selectable: true,
        selectHelper: true,
        select: function(start, end, allDay) {
            var title = prompt('Event Title:');
            if (title) {
                $('#calendar').fullCalendar('renderEvent',
                    {
                        title: title,
                        start: start,
                        end: end,
                        allDay: allDay
                    },
                    true // make the event "stick"
                );
            }
            $('#calendar').fullCalendar('unselect');
        },
        editable: true,
        loading: function(bool){
            if (bool)
                $('#loading').show();
            else
                $('#loading').hide();
        },

        // a future calendar might have many sources.
        eventSources: [{
            url: '/events',
            color: 'black',
            textColor: 'white',
            ignoreTimezone: true

        }],

        timeFormat: 'h:mm t{ - h:mm t} ',
        dragOpacity: "0.5",

        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
//            $('#calendar').fullCalendar('removeEvents', event.id);
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        eventResize: function(event, dayDelta, minuteDelta, revertFunc){
//            if (event._end == null)
//               event._end = event._start
//               i=5
            updateEvent(event);
        },


        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
            // would like a lightbox here.
        }
    });
});



function updateEvent(the_event) {
    $.update(
        "/events/" + the_event.id,
        { event: { title: the_event.title,
            starts_at: "" + the_event.start,
            ends_at: "" + the_event.end,
            description: the_event.description
        }
        },
        function (reponse) { alert('successfully updated task.'); }
    ); }

function removeEvents(the_event) {
    $.destroy(
        "/events/" + the_event.id,
        { event: { title: the_event.title,
            starts_at: "" + the_event.start,
            ends_at: "" + the_event.end,
            description: the_event.description
        }
        },
        function (reponse) { alert('successfully updated task.'); }
    );
};
