$(document).on('page:load', function(){
  $('.message .close')
    .on('click', function() {
      $(this)
        .closest('.message')
        .transition('fade');
    });
})