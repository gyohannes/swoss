$(function () {
    $("#search_mrn, #search_first_name, #search_father_name").change(function(){
        var mrn = $("#search_mrn").val()
        var first_name = $("#search_first_name").val()
        var father_name = $("#search_father_name").val()
        $.ajax({
            url: '/or_schedules/load_patients',
            data: {mrn: mrn, first_name: first_name, father_name: father_name},
            success: function(response){
                $('#patients_list').html(response);
            }
        });
    });

    $(".days").click(function(){
        var days = $(this).text()
        $.ajax({
            url: '/patients/load_appointments',
            data: {days: days},
            success: function(response){
                $('#appointment_list').html(response);
            }
        });
    });
});