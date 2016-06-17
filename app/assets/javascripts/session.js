$(document).on('ready', closeNag)

function closeNag(){
  $(document).ready(function(){
    $('.ui.inline.nag > .close.icon').on('click', function(){
      $('.ui.nag').css('display', 'none');
      console.log("Clicked!");
    });
  })
}
