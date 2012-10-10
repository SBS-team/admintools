
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
        monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
        monthNamesShort: ['Янв.','Фев.','Март','Апр.','Май','Июнь','Июль','Авг.','Сент.','Окт.','Ноя.','Дек.'],
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
            var width = 1200; 										//Use an integer (in pixels)
            var padding = 10;										//Use an integer (in pixels)
            var backgroundColor = '#FFFFFF'; 						//Use any hex code
            var source = '/admin/events/new/' + start +  '/' + end +  '/' + allDay;
            var borderColor = '#333333'; 							//Use any hex code
            var borderWeight = 4; 									//Use an integer (in pixels)
            var borderRadius = 5; 									//Use an integer (in pixels)
            var fadeOutTime = 300; 									//Use any integer, 0 = no fade
            var disableColor = '#666666'; 							//Use any hex code
            var disableOpacity = 40; 								//Valid range 0-100
            var loadingImage = '';		//Use relative path from this page

            //This method initialises the modal popup
            modalPopup(align, top, width, padding, disableColor, disableOpacity, backgroundColor, borderColor, borderWeight, borderRadius, fadeOutTime, source, loadingImage);
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
            url: '/admin/events',
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
            var align = 'center';									//Valid values; left, right, center
            var top = 100; 											//Use an integer (in pixels)
            var width = 300; 										//Use an integer (in pixels)
            var padding = 10;										//Use an integer (in pixels)
            var backgroundColor = '#FFFFFF'; 						//Use any hex code
            var source = '/events/' + event.id;
            var borderColor = '#333333'; 							//Use any hex code
            var borderWeight = 4; 									//Use an integer (in pixels)
            var borderRadius = 5; 									//Use an integer (in pixels)
            var fadeOutTime = 300; 									//Use any integer, 0 = no fade
            var disableColor = '#666666'; 							//Use any hex code
            var disableOpacity = 40; 								//Valid range 0-100
            var loadingImage = '';		//Use relative path from this page

            //This method initialises the modal popup
            modalPopup(align, top, width, padding, disableColor, disableOpacity, backgroundColor, borderColor, borderWeight, borderRadius, fadeOutTime, source, loadingImage);

            $('#calendar').fullCalendar('unselect');
          return false;
        }

    });

});

//$('.fc-event-inner').append('<div id="calendarTrash" style="float: right; padding-top: 5px; padding-right: 5px; padding-left: 5px;"><span class="ui-icon ui-icon-trash"></span></div>');

function updateEvent(the_event) {
    $.update(
        "/admin/events/" + the_event.id,
        { event: { title: the_event.title,
            starts_at: "" + the_event.start,
            ends_at: "" + the_event.end,
            description: the_event.description
        }
        },
        function (reponse) { alert('successfully updated task.'); }
    );
};

function PopupEventEdit(id) {
    var align = 'center';									//Valid values; left, right, center
    var top = 100; 											//Use an integer (in pixels)
    var width = 1200; 										//Use an integer (in pixels)
    var padding = 10;										//Use an integer (in pixels)
    var backgroundColor = '#FFFFFF'; 						//Use any hex code
    var source = "/admin/events/"+id+"/edit";
    var borderColor = '#333333'; 							//Use any hex code
    var borderWeight = 4; 									//Use an integer (in pixels)
    var borderRadius = 5; 									//Use an integer (in pixels)
    var fadeOutTime = 300; 									//Use any integer, 0 = no fade
    var disableColor = '#666666'; 							//Use any hex code
    var disableOpacity = 40; 								//Valid range 0-100
    var loadingImage = '';		//Use relative path from this page
    //This method initialises the modal popup
    modalPopup(align, top, width, padding, disableColor, disableOpacity, backgroundColor, borderColor, borderWeight, borderRadius, fadeOutTime, source, loadingImage);
};

