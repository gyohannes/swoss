$(function(){$("#report_from").calendarsPicker($.extend({calendar:$.calendars.instance("ethiopian","am"),dateFormat:"mm/yyyy",daySelect:!1,maxDate:"0m",onChangeMonthYear:function(e,a){$("#report_from").val(a+"/"+e);var r=$("#report_from").val(),t=$("#report_to").val();$.ajax({url:"/report/load_surgical_service",data:{from:r,to:t},success:function(e){$("#surgical_service_report").html(e)}})}})),$("#report_to").calendarsPicker($.extend({calendar:$.calendars.instance("ethiopian","am"),dateFormat:"mm/yyyy",defaultDate:"0d",selectDefaultDate:!0,maxDate:"0d",onChangeMonthYear:function(e,a){$("#report_to").val(a+"/"+e);var r=$("#report_from").val(),t=$("#report_to").val();$.ajax({url:"/report/load_surgical_service",data:{from:r,to:t},success:function(e){$("#surgical_service_report").html(e)}})}})),$("#efficiency_report_from").calendarsPicker($.extend({calendar:$.calendars.instance("ethiopian","am"),dateFormat:"mm/yyyy",daySelect:!1,maxDate:"0m",onChangeMonthYear:function(e,a){$("#efficiency_report_from").val(a+"/"+e);var r=$("#efficiency_report_from").val(),t=$("#efficiency_report_to").val();$.ajax({url:"/report/load_surgical_service_efficiency",data:{from:r,to:t},success:function(e){$("#surgical_service_efficiency_report").html(e)}})}})),$("#efficiency_report_to").calendarsPicker($.extend({calendar:$.calendars.instance("ethiopian","am"),dateFormat:"mm/yyyy",defaultDate:"0d",selectDefaultDate:!0,maxDate:"0d",onChangeMonthYear:function(e,a){$("#efficiency_report_to").val(a+"/"+e);var r=$("#efficiency_report_from").val(),t=$("#efficiency_report_to").val();$.ajax({url:"/report/load_surgical_service_efficiency",data:{from:r,to:t},success:function(e){$("#surgical_service_efficiency_report").html(e)}})}})),$("#custom_report_from").calendarsPicker($.extend({calendar:$.calendars.instance("ethiopian","am"),dateFormat:"mm/yyyy",daySelect:!1,maxDate:"0m",onChangeMonthYear:function(e,a){$("#custom_report_from").val(a+"/"+e);var r=$("#custom_report_from").val(),t=$("#custom_report_to").val();$.ajax({url:"/report/load_admissions",data:{from:r,to:t},success:function(e){$("#custom_report").html(e)}})}})),$("#custom_report_to").calendarsPicker($.extend({calendar:$.calendars.instance("ethiopian","am"),dateFormat:"mm/yyyy",defaultDate:"0d",selectDefaultDate:!0,maxDate:"0d",onChangeMonthYear:function(e,a){$("#custom_report_to").val(a+"/"+e);var r=$("#custom_report_from").val(),t=$("#custom_report_to").val();$.ajax({url:"/report/load_admissions",data:{from:r,to:t},success:function(e){$("#custom_report").html(e)}})}}))});