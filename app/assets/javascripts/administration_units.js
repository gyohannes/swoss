$(function () {
    $.ajax({
        url: '/administration_units/load_tree',
        success: function(response){
            $('#administration_unit_tree').treeview({
                data: response,
                levels: 1,
                expandIcon: 'fa fa-plus-circle',
                collapseIcon: 'fa fa-minus-circle',
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/administration_units/load_sub_units',
                        data: { node: data.id},
                        success: function (response) {
                            $('#administration_unit').html(response)
                            $('.dataTable').DataTable({
                                responsive: true,
                                retrieve: true,
                            });
                        }
                    })
                }
            });
        }
    });

});