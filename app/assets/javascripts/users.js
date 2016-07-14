function deleteConfirmDialog(reference_number){
  $('.ui.basic.modal').modal('show');
  document.reference_number = reference_number;
}

function deleteReservation(){
  $('.ui.basic.modal').modal('hide');
  $('#search-result-container').empty();
  toastr.info("Booking has been succesfully deleted", "Info")
  $.ajax({
    url: "/bookings/"+document.reference_number,
    type: 'DELETE',
    success: function(){
      var tableRow = 'tr#'+document.reference_number
      if($(tableRow)){
        $(tableRow).remove();
      }
      else{
        $('#search-result-container').empty();
      }
    },
    error: function(){
      console.log("Failed to delete booking")
    }
  });
}
