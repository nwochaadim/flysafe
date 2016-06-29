function deleteConfirmDialog(reference_number){
  $('.ui.basic.modal').modal('show');
  document.reference_number = reference_number;
}

function deleteReservation(){
  $('.ui.basic.modal').modal('hide');
  
  $.ajax({
    url: "/bookings/"+document.reference_number,
    type: 'DELETE',
    success: function(){
      var tableRow = 'tr#'+document.reference_number
      $(tableRow).remove()
    },
    error: function(){
      console.log("Failed to delete booking")
    }
  });
  
}
