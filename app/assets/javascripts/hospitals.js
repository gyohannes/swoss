$(function () {
    $(function () {
        $.ajax({
            url: '/administration_units/load_tree',
            success: function(response){
                $('#hospital_administration_unit_tree').treeview({
                    data: response,
                    levels: 0,
                    expandIcon: 'fa fa-plus-circle',
                    collapseIcon: 'fa fa-minus-circle',
                    onNodeSelected: function (event, data) {
                        $('#hospital_administration_unit_id').val(data.id)
                    }
                });
            }
        });

    });
})