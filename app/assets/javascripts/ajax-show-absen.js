var anton = ''
$(document).ready(function() {
  // alert('sd')
  
  $('.js-show-absen-ajax').change(function(e){
    var employee_id = $('#slip_employee_id').val();
    var month = $('#slip_month').val();
    var year = $('#slip_year').val();
    
    if(employee_id == ''){
      // nothing
    } else {
      $.ajax({
        url: '/admin/slips/get_absensi',
        data: {
          employee_id: employee_id,
          month: month,
          year: year
        },
        success: function(data) {
          anton = data
          console.log(anton)
          $('#absen_list').html('');
          $('#absen_list').html(data.html);
        }
      })
    }

  });

  $('#slip_month').change();

});
