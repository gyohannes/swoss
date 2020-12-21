$(function () {
    $("#surgical_service_post_schedule_status").change(function(){
        var status = $(this).val();
        $.ajax({
            url: '/surgical_services/load_sub_form',
            data: {status: status},
            success: function(response){
                $('#surgical_service_sub_form_display').html(response);
            }
        });
    });

    $("#surgical_service_immediate_postoperative_outcome").change(function(){
        var outcome = $(this).val();
        $.ajax({
            url: '/surgical_services/load_death_reason',
            data: {outcome: outcome},
            success: function(response){
                $('#death_reason_display').html(response);
            }
        });
    });

    $("#surgical_service_adverse_event_happened").change(function(){
        var adverse_event = $(this).val();
        $.ajax({
            url: '/surgical_services/load_adverse_event',
            data: {adverse_event: adverse_event},
            success: function(response){
                $('#adverse_event_display').html(response);
            }
        });
    });
});