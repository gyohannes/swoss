$(function () {
    $("#admission_admission_type").change(function(){
        var admission_type = $(this).val();
        $.ajax({
            url: '/admissions/load_sub_form',
            data: {admission_type: admission_type},
            success: function(response){
                $('#sub_admission_form').html(response);
            }
        });
    });

    $("#admission_listing_status").change(function(){
        var listing_status = $(this).val()
        var procedure = $("#admission_procedure_id").val();
        $.ajax({
            url: '/admissions/load_information',
            data: {listing_status: listing_status, procedure: procedure},
            success: function(response){
                $('#information_display').html(response);
            }
        });
    });
});