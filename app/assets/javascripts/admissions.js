$(function () {
    $('.ethiopian_date_picker').calendarsPicker($.extend({
        calendar: $.calendars.instance('ethiopian', 'am'),
        dateFormat: 'dd/mm/yyyy',
        maxDate: '1y'
    }));

    $("#admission_admission_type").change(function(){
        var admission_type = $(this).val();
        var procedure_category = $("#admission_procedure_category_id").val();
        $.ajax({
            url: '/admissions/load_sub_form',
            data: {admission_type: admission_type, category: procedure_category},
            success: function(response){
                $('#sub_admission_form').html(response);
            }
        });
    });

    $("#admission_admission_type").change(function(){
        var admission_type = $(this).val();
        var procedure_category = $("#admission_procedure_category_id").val();
        $.ajax({
            url: '/admissions/load_sub_form',
            data: {admission_type: admission_type, category: procedure_category},
            success: function(response){
                $('#sub_admission_form').html(response);
            }
        });
    });

    $("#admission_listing_status, #admission_priority").change(function(){
        var listing_status = $(this).val()
        var procedure = $("#admission_procedure_id").val();
        var priority = $("#admission_priority").is(":checked");
        $.ajax({
            url: '/admissions/load_information',
            data: {listing_status: listing_status, procedure: procedure, priority: priority},
            success: function(response){
                $('#information_display').html(response);
            }
        });
    });

    $("#admission_procedure_id").change(function(){
        var procedure = $("#admission_procedure_id").val();
        $.ajax({
            url: '/admissions/load_category',
            data: {procedure: procedure},
            success: function(response){
                $('#procedure_category_display').html(response);
            }
        });
    });

    $("#admission_procedure_id").change(function(){
        var procedure = $("#admission_procedure_id").val();
        $.ajax({
            url: '/admissions/load_priority',
            data: {procedure: procedure},
            success: function(response){
                $('#priority_display').html(response);
            }
        });
    });

    $("#admission_procedure_id, #admission_priority, #admission_listing_status, #admission_appointment_date").change(function(){
        var procedure = $("#admission_procedure_id").val();
        var priority = $("#admission_priority").is(":checked");
        var listing_status = $("#admission_listing_status").val();
        var appointment_date = $("#admission_appointment_date").val();
        $.ajax({
            url: '/admissions/load_submit',
            data: {procedure: procedure, priority: priority, listing_status: listing_status, appointment_date: appointment_date},
            success: function(response){
                $('#submit_display').html(response);
            }
        });
    });
});