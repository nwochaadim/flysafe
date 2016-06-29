class UserMailer < ApplicationMailer
  def welcome(id)
    @user = User.find(id)
    mail(to: @user.email, subject: "Welcome to FlySafe")
  end

  def delete_reservation(user, booking_id)
    @user = user
    @booking = Booking.find(booking_id)
    mail(to: user.email, subject: "Fly Safe. Booking Reservation Cancelled")
  end
end
