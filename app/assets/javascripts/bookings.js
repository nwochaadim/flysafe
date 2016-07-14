$(document).on('ready page:load', function(){
  $('.ui.red.basic.inverted.button').click(function(){
    $('.ui.basic.modal').modal('hide');
  })

})

function showPassenger(){
  $('#passengers-modal').modal('show')
}


function editReservation(){
  $('.ui.long.modal.mform').modal('show')
}

function addPassengerForm(type){

  var no_of_passengers = $('.custom-form').length + 1
    
  $.when(isFlightBookable()).then(function(res){
    if (res.seats_available >= no_of_passengers){
      $('#passenger-form').append(passengerFormString(type))
      $('.ui.long.modal.mform').modal('refresh')
    }
    else{
      toastr.info("Sorry! The flight cannot contain this passenger", "Flight Occupied!");
    }

  }, function(res){
    toastr.error("An Error occured while trying to retreive the flight information", "Error!");
  })
  
}

function removePassengerForm(ele){
  var parentElement = $(ele).parent()
  parentElement.remove();
  $('.ui.long.modal.mform').modal('refresh');
}

function passengerFormString(type){
  return [
    '<div class="custom-form">',
      '<h4 class="ui dividing header"> '+type.ucfirst()+ ' Passenger Information</h4>',
        '<div class="two fields">',
          '<div class="field">',
            '<label for="first_name">First Name</label>',
            '<input type="text" name="'+type+"[][first_name]"+'" placeholder: "E.g John" required = true />',
          '</div>',

          '<div class="field">',
            '<label for="last_name">Last Name</label>',
            '<input type="text" name="'+type+"[][last_name]"+'" placeholder: "E.g Doe" required = true />',
          '</div>',
        '</div>',
        '<div class="four wide field">',
          '<label for="gender">Gender</label>',
          '<select name="'+type+"[][gender]"+'" class="ui fluid dropdown">',
            '<option value="Male">Male</option>',
            '<option value="Female">Female</option>',
          '</select>',
        '</div>',
        '<button class="ui basic button" onclick="removePassengerForm(this)">Remove Passenger</button>',
        '<br/><br/>',
      '</div>'
  ].join('')
}

function retrieveBookingInfo(){
   $.ajax({
    url: "/bookings/book",
    type: "POST",
    success: function(){
      console.log("Successful!")
    },
    error: function(){
      alert("Failed to retrieve booking")
    }
  });
}

function isFlightBookable(){
  var deferred = jQuery.Deferred();
  $.ajax({
    url: "/flights/seats_available",
    type: 'GET',
    success: function(res){
       deferred.resolve(res);
    },
    error: function(res){
      deferred.reject(res);
    }
  });
  return deferred.promise();
}


String.prototype.ucfirst = function()
{
  return this.charAt(0).toUpperCase() + this.substr(1);
}

