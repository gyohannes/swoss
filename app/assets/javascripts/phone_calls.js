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
});