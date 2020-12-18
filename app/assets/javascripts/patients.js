$(function () {
    $("#patient_search_MRN, #patient_search_first_name, #patient_search_father_name, " +
            "#patient_search_grand_father_name, #patient_search_phone_number").
        on("input", function () {
            var mrn = $("#patient_search_MRN").val();
            var first_name = $("#patient_search_first_name").val();
            var father_name = $("#patient_search_father_name").val();
            var grand_father_name = $("#patient_search_grand_father_name").val();
            var phone_number = $("#patient_search_phone_number").val();
            var first_name = $("#patient_search_first_name").val();
            $.ajax({
                url: '/patients/load_patients',
                data: {mrn: mrn, first_name: first_name, father_name: father_name,
                    grand_father_name: grand_father_name, phone_number: phone_number},
                success: function (response) {
                    $("#patients_list").html(response)
                    $('.dataTable').DataTable({
                        responsive: true,
                        retrieve: true,
                    });
                }
            })
        });

    $(".days").click(function(){
        var days = $(this).text()
        $.ajax({
            url: '/patients/load_appointments',
            data: {days: days},
            success: function(response){
                $('#appointment_list').html(response);
                $('.dataTable').DataTable({
                    responsive: true,
                    retrieve: true,
                });
            }
        });
    });

    $(function () {
        $.ajax({
            url: '/administration_units/load_tree',
            success: function(response){
                $('#patient_administration_unit_tree').treeview({
                    data: response,
                    levels: 0,
                    expandIcon: 'fa fa-plus-circle',
                    collapseIcon: 'fa fa-minus-circle',
                    onNodeSelected: function (event, data) {
                        if (data.type == 'Woreda') {
                            $('#patient_administration_unit_id').val(data.id)
                        }
                    }
                });
            }
        });

    });
});