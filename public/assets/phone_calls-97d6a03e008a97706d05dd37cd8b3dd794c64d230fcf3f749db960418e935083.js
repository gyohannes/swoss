$(function(){$("#phone_call_patient_response").change(function(){var a=$(this).val(),n=$("#phone_call_admission_id").val();$.ajax({url:"/phone_calls/load_sub_form",data:{response:a,admission:n},success:function(a){$("#sub_form_display").html(a)}})}),$("#phone_call_action").change(function(){var a=$(this).val();$.ajax({url:"/phone_calls/load_appointment_date",data:{action_value:a},success:function(a){$("#date_display").html(a)}})})});