$(function () {
    $("#or_schedule_procedure_type").change(function(){
        var procedure_type = $(this).val();
        $.ajax({
            url: '/or_schedules/load_sub_form',
            data: {procedure_type: procedure_type},
            success: function(response){
                $('#procedure_sub_form_display').html(response);
            }
        });
    });
});