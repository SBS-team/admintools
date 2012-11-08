$(document).ready(function() {
    $('.delete_skill').click(function() {
        var current = $(this);
//        if (current.data(''))
        current.parent().remove();
    });

    $('.add_skill').click(function() {
        var current = $(this);
        var form = $(this).closest('form');
    });
});
