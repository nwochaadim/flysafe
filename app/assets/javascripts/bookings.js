$(document).on('ready page:load', function(){
  $('.ui.red.basic.inverted.button').click(function(){
    $('.ui.basic.modal').modal('hide');
  })
})

function confirmDialog(){
  $('.ui.basic.modal').modal('show');
}

function showPassenger(){
  $('#passengers-modal').modal('show')
}