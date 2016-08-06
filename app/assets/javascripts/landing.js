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
  if (validateSuppliedDate() && validateDepartsArrives()){
    submitForm();
  }
  else{
    return false;
  }
  
}

function validateSuppliedDate(){
  var suppliedDate = $('#date').val();
  if (suppliedDate !== ""){
    var timeAllowance = 1000 * 60 * 60 * 23.99
    var presentTimeStamp = new Date().getTime();
    var suppliedTimeStamp = new Date(suppliedDate).getTime() + timeAllowance;
    
    if(suppliedTimeStamp < presentTimeStamp){
      toastr.error("You cant enter a date in the past", "Error!");
      return false;
    }
    else{
      return true
    }
  }
  toastr.error("Please enter a date", "Error!");
  return false;
}

function validateDepartsArrives(){
  if($('#departs').val()===$('#arrives').val()){
    toastr.error("Departing and Arriving Airport cannot be the same", "Error!")
    return false;
  }
  else{
    return true;
  }
}

function submitForm(){
  $(".ui.form").submit();
  $("#progress-container").addClass("loading");
}