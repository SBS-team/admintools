function toDelete() {

}

$(document).ready(function() {
    $('.delete_skill').live('click', function() {
        var current = $(this);
        if (current.data('exist')) {
            var moved = $(current.parent().prev().find('select'));
            if (current.closest('#deleted').length > 0) {
                moved.attr('name', moved.attr('name').replace("delete", "score"));
                current.closest('tr').appendTo('#skills');
                current.text("удалить");
                current.removeClass("btn-success").addClass("btn-danger");
            } else {
                moved.attr('name', moved.attr('name').replace("score", "delete"));
                current.closest('tr').appendTo('#deleted');
                current.text("восстановить");
                current.addClass("btn-success").removeClass("btn-danger");
            }
        }
        else current.closest('tr').remove();
    });

    $('.add_skill').live('click', function() {
        var current = $(this).prev().find(':selected');
        var skill_id = current.val();
        var skill_name = current.text();
        if ($('[name="skill[score][' + skill_id + ']"]').length > 0)
            alert("Данный скил уже есть в списке");
        else $('#skills').append(shablon.replace("#name", skill_name).replace("#id", skill_id));
    });
});
