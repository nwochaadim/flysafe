class UserMailer < ApplicationMailer
  def welcome(id)
    @user = User.find(id)
    mail(to: @user.email, subject: "Welcome to FlySafe")
  end

  def booking_success(booking)
    @user = booking.user || booking.unregistered_user
    @booking = booking
    @new_cost = new_cost(@booking.passengers, @booking.class_level.to_sym)
    mail(to: @user.email, subject: "Booking was successful")
  end

  def delete_reservation(user, booking_id)
    @user = user
    @booking = Booking.find(booking_id)
    mail(to: @user.email, subject: "Fly Safe. Booking Reservation Cancelled!")
  end

  def update_reservation(user, booking_id)
    @user = user
    @booking = Booking.find(booking_id)
    @new_cost = new_cost(@booking.passengers, @booking.class_level.to_sym)
    mail(to: user.email, subject: "Fly Safe. Booking Reservation Updated!")
  end

  private

  def new_cost(passengers, class_level)
    total_cost = fares[class_level]
    passengers.each do |passenger|
      total_cost += fares[class_level] unless passenger.age_grade == "Infant"
    end
    total_cost
  end

  def fares
    {
      Economy: 1000,
      Business: 5000
    }
  end
end
