$(document).on('page:load', function(){
  $('.message .close')
    .on('click', function() {
      $(this)
        .closest('.message')
        .transition('fade');
    });
})

function validateFields(evt){
  evt.preventDefault();
  var suppliedDate = $('#date').val();
  
  if (suppliedDate){
    suppliedTimeStamp = new Date(suppliedDate).getTime();
    presentTimeStamp = Date.now()
    if(suppliedTimeStamp < presentTimeStamp){
      toastr.error("You cant enter a date in the past", "Error!");
      return false;
    }
  }

  if($('#departs').val()===$('#arrives').val()){
    toastr.error("Departing and Arriving Airport cannot be the same", "Error!")
    return false;
  }
  
  $(".ui.form").submit();
  $("#progress-container").addClass("loading");
}
