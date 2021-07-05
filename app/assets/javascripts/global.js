$(function () {
    $('.ethiopian_date_picker').calendarsPicker($.extend({
        calendar: $.calendars.instance('ethiopian', 'am'),
        dateFormat: 'dd/mm/yyyy',
        maxDate: '1y'
    }));

    $('.date_picker').calendarsPicker();

    $('#patient_date_of_birth').calendarsPicker($.extend({
        calendar: $.calendars.instance('ethiopian', 'am'),
        dateFormat: 'dd/mm/yyyy',
        minDate: '-100y',
        maxDate: '0d',
        defaultDate: null,
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

    $('.time_picker').mdtimepicker({
        clearBtn: true
    });

    $('.dataTable').DataTable({
        responsive: true,
        retrieve: true,
    });

    $('.buttons-dataTable').DataTable({
        responsive: true,
        retrieve: true,
        dom: 'Bfrtip',
        buttons: [
            'colvis', { extend: 'excelHtml5', footer: true }
        ]
    });

    $('select').select2();
});
