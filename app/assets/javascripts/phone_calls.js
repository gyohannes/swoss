$(function () {
    $("#phone_call_patient_response").change(function(){
        var response = $(this).val();
        var admission = $("#phone_call_admission_id").val();
        $.ajax({
            url: '/phone_calls/load_sub_form',
            data: {response: response, admission: admission},
            success: function(response){
                $('#sub_form_display').html(response);
            }
        });
    });

    $("#phone_call_action").change(function(){
        var action = $(this).val();
        $.ajax({
            url: '/phone_calls/load_appointment_date',
            data: {action_value: action},
            success: function(response){
                $('#date_display').html(response);
            }
        });
    });

    $('.ethiopian_date_picker').calendarsPicker($.extend({
        calendar: $.calendars.instance('ethiopian', 'am'),
        dateFormat: 'dd/mm/yyyy',
        maxDate: '1y'
    }));

});