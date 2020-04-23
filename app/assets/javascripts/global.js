$(function () {
    $('.ethiopian_date_picker').calendarsPicker($.extend({
        calendar: $.calendars.instance('ethiopian', 'am'),
        dateFormat: 'dd/mm/yyyy',
        maxDate: '1y'
    }));

    $('#patient_date_of_birth').calendarsPicker($.extend({
        calendar: $.calendars.instance('ethiopian', 'am'),
        dateFormat: 'dd/mm/yyyy',
        minDate: '-100y',
        maxDate: '0d',
        onChangeMonthYear: function(year){
            $("#patient_date_of_birth").val("01/06/" + year)
            var dob = $(this).val()
            $.ajax({
                url: '/patients/load_age',
                data: {dob: dob},
                success: function(response){
                    $('#age_form').html(response);
                }
            });
        },
        onSelect: function () {
            var dob = $(this).val()
            $.ajax({
                url: '/patients/load_age',
                data: {dob: dob},
                success: function(response){
                    $('#age_form').html(response);
                }
            });
        }
    }));

    $('#report_from').calendarsPicker($.extend({
        calendar: $.calendars.instance('ethiopian', 'am'),
        dateFormat: 'mm/yyyy',
        daySelect: false,
        maxDate: '0m',
    onChangeMonthYear: function(year, month){
            $("#report_from").val(month + "/" + year)
            var from = $("#report_from").val()
            var to = $("#report_to").val()
            $.ajax({
                url: '/report/load_surgical_service',
                data: {from: from, to: to},
                success: function(response){
                    $('#surgical_service_report').html(response);
                }
            });
        }
    }));


    $('#report_to').calendarsPicker($.extend({
        calendar: $.calendars.instance('ethiopian', 'am'),
        dateFormat: 'mm/yyyy',
        defaultDate: '0d', selectDefaultDate: true,
        maxDate: '0d',
        onChangeMonthYear: function(year, month){
            $("#report_to").val(month + "/" + year)
            var from = $("#report_from").val()
            var to = $("#report_to").val()
            $.ajax({
                url: '/report/load_surgical_service',
                data: {from: from, to: to},
                success: function(response){
                    $('#surgical_service_report').html(response);
                }
            });
        }
    }));

    $('#efficiency_report_from').calendarsPicker($.extend({
        calendar: $.calendars.instance('ethiopian', 'am'),
        dateFormat: 'mm/yyyy',
        daySelect: false,
        maxDate: '0m',
        onChangeMonthYear: function(year, month){
            $("#efficiency_report_from").val(month + "/" + year)
            var from = $("#efficiency_report_from").val()
            var to = $("#efficiency_report_to").val()
            $.ajax({
                url: '/report/load_surgical_service_efficiency',
                data: {from: from, to: to},
                success: function(response){
                    $('#surgical_service_efficiency_report').html(response);
                }
            });
        }
    }));


    $('#efficiency_report_to').calendarsPicker($.extend({
        calendar: $.calendars.instance('ethiopian', 'am'),
        dateFormat: 'mm/yyyy',
        defaultDate: '0d', selectDefaultDate: true,
        maxDate: '0d',
        onChangeMonthYear: function(year, month){
            $("#efficiency_report_to").val(month + "/" + year)
            var from = $("#efficiency_report_from").val()
            var to = $("#efficiency_report_to").val()
            $.ajax({
                url: '/report/load_surgical_service_efficiency',
                data: {from: from, to: to},
                success: function(response){
                    $('#surgical_service_efficiency_report').html(response);
                }
            });
        }
    }));

    $('.time_picker').mdtimepicker();

    $('.dataTable').DataTable();
});
