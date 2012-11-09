$(document).ready(function() {
    $('.delete_skill').click(function() {
        var current = $(this);
        if (current.data('exist') === 1) {
            var moved = $(current.parent().prev().find('select'));
            if (current.closest('#deleted').length > 0) {
                moved.attr('name', moved.attr('name').replace("delete", "score"));
                current.closest('tr').appendTo('#skills');
            } else {
                moved.attr('name', moved.attr('name').replace("score", "delete"));
                current.closest('tr').appendTo('#deleted');
            }
        }
        else current.closest('tr').remove();
    });

    $('.add_skill').click(function() {
        var current = $(this).prev().find(':selected');
        var skill_id = current.val();
        var skill_name = current.text();
        if ($('[name="skill[score][' + skill_id + ']"]').length > 0)
            alert("Данный скил уже есть в списке");
        else $('#skills').append(shablon.replace("#name", skill_name).replace("#id", skill_id));
    });
});
