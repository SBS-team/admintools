$(document).ready(function() {
    $('.delete_range').live('click', function() {

    });

    $('.approve_range').live('click', function() {

    });
});

function initDates(dates) {
    $.each(new Array(dates), function() {
        $('#datepickers').DatePickerSetDate(date, false);
    });
}