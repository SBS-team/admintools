
$(document).ready(function() {

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $('#calendar').fullCalendar({
        firstDay: 1,
        theme: true,
        height: 600,
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        monthNames: ['Январь','Февраль','Март','Апрель','Май','οюнь','οюль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
        monthNamesShort: ['Янв.','Фев.','Март','Апр.','Май','οюнь','οюль','Авг.','Сент.','Окт.','Ноя.','Дек.'],
        dayNames: ["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"],
        dayNamesShort: ["ВС","ПН","ВТ","СР","ЧТ","ПТ","СБ"],
        buttonText: {
            prev: "&nbsp;&#9668;&nbsp;",
            next: "&nbsp;&#9658;&nbsp;",
            prevYear: "&nbsp;&lt;&lt;&nbsp;",
            nextYear: "&nbsp;&gt;&gt;&nbsp;",
            today: "Сегодня",
            month: "Месяц",
            week: "Неделя",
            day: "День"
        },
        selectable: true,
        selectHelper: true,
        select: function(start, end, allDay) {
            //Change these values to style your modal popup
            var align = 'center';									//Valid values; left, right, center
            var top = 100; 											//Use an integer (in pixels)
            var width = 500; 										//Use an integer (in pixels)
            var padding = 10;										//Use an integer (in pixels)
            var backgroundColor = '#FFFFFF'; 						//Use any hex code
            var source = '/calendar/popup/' + start + '/' + end + '/' + allDay; 								//Refer to any page on your server, external pages are not valid e.g. http://www.google.co.uk
            //var source = '/calendar/popup/:start/:end/:allDay';
            var borderColor = '#333333'; 							//Use any hex code
            var borderWeight = 4; 									//Use an integer (in pixels)
            var borderRadius = 5; 									//Use an integer (in pixels)
            var fadeOutTime = 300; 									//Use any integer, 0 = no fade
            var disableColor = '#666666'; 							//Use any hex code
            var disableOpacity = 40; 								//Valid range 0-100
            var loadingImage = '';		//Use relative path from this page

            //This method initialises the modal popup
                modalPopup(align, top, width, padding, disableColor, disableOpacity, backgroundColor, borderColor, borderWeight, borderRadius, fadeOutTime, source, loadingImage);

              //alert(start);
//            var title = prompt('Event Tывывывtle:');
//            if (title) {
//                $('#calendar').fullCalendar('renderEvent',
//                    {
//                        title: title,
//                        start: start,
//                        end: end,
//                        allDay: allDay
//                    },
//                    true // make the event "stick"
//
//                );
//            }
            $('#calendar').fullCalendar('unselect');
        },
        editable: true,
        draggable:true,
        loading: function(bool){
            if (bool)
                $('#loading').show();
            else
                $('#loading').hide();
        },

        // a future calendar might have many sources.
        eventSources: [{
            url: '/events',
            ignoreTimezone: true

        }],

        timeFormat: 'h:mm t{ - h:mm t} ',
        dragOpacity: "0.5",

        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){

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

        }

    });

});

//$('.fc-event-inner').append('<div id="calendarTrash" style="float: right; padding-top: 5px; padding-right: 5px; padding-left: 5px;"><span class="ui-icon ui-icon-trash"></span></div>');

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
    );
};


