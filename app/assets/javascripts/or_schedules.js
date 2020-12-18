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

    $('#add-assisstant-button').click(function () {
        var newAssisstantField = $('input[name="or_schedule[assisstant_surgeons][]"]:last').clone()
        newAssisstantField.val("")
        $('#assisstant_surgeons').append(newAssisstantField);
    })

    $("#search_mrn, #search_department").change(function(){
        var mrn = $("#search_mrn").val()
        var department = $("#search_department").val()
        $.ajax({
            url: '/or_schedules/load_patients',
            data: {mrn: mrn, department: department},
            success: function(response){
                $('#patients_list').html(response);
            }
        });
    });
});