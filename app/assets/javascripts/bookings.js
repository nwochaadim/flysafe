$(document).on('ready page:load', function(){
  $('.ui.red.basic.inverted.button').click(function(){
    $('.ui.basic.modal').modal('hide');
  })
})

function showPassenger(){
  $('#passengers-modal').modal('show')
}


function deleteBookingReservation(reference_number){
  $('.ui.basic.modal').modal('hide');
  
  $.ajax({
    url: "/bookings/"+document.reference_number,
    type: 'DELETE',
    success: function(){
      $('#search-result-container').html("");
    },
    error: function(){
      console.log("Failed to delete booking");
    }
  });
}

function editReservation(){
  $('.ui.long.modal.mform').modal('show')
}

function addPassengerForm(type){
  $('#passenger-form').append(passengerFormString(type))
  $('.ui.long.modal.mform').modal('refresh')
}

function removePassengerForm(ele){
  var parentElement = $(ele).prev('div.two.fields')
  var siblingElement = parentElement.prev()
  parentElement.remove()
  siblingElement.remove()
  ele.remove()
  $('.ui.long.modal.mform').modal('refresh')
}

function passengerFormString(type){
  return [
    '<h4 class="ui dividing header"> '+type.ucfirst()+ ' Passenger Information</h4>',
      '<div class="two fields">',
        '<div class="field">',
          '<label for="first_name">First Name</label>',
          '<input type="text" name="'+type+"[][first-name]"+'" placeholder: "E.g John" required = true />',
        '</div>',

        '<div class="field">',
          '<label for="last_name">Last Name</label>',
          '<input type="text" name="'+type+"[][last-name]"+'" placeholder: "E.g Doe" required = true />',
        '</div>',
      '</div>',
      '<button class="ui basic button" onclick="removePassengerForm(this)">Remove Passenger</button>',
      '<br/><br/>'
  ].join('')
}

function retrieveBookingInfo(){
  console.log("Retrieved!")
   $.ajax({
    url: "/book",
    type: "POST",
    success: function(){
      console.log("Successful!")
    },
    error: function(){
      console.log("Failed to delete booking")
    }
  });
}

String.prototype.ucfirst = function()
{
  return this.charAt(0).toUpperCase() + this.substr(1);
}

