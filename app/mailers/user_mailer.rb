class UserMailer < ApplicationMailer
  def welcome(id)
    @user = User.find(id)
    mail(to: @user.email, subject: "Welcome to FlySafe")
  end

  def booking_success(booking_id)
    @booking = Booking.find(booking_id)
    @user = @booking.user
    @new_cost = new_cost(@booking.passengers, @booking.class_level.to_sym)
    mail(to: @user.email, subject: "Booking was successful")
  end

  def delete_reservation(booking_id)
    @booking = Booking.find(booking_id)
    @user = @booking.user
    mail(to: @user.email, subject: "Fly Safe. Booking Reservation Cancelled!")
  end

  def update_reservation(booking_id)
    @booking = Booking.find(booking_id)
    @user = @booking.user
    @new_cost = new_cost(@booking.passengers, @booking.class_level.to_sym)
    mail(to: @user.email, subject: "Fly Safe. Booking Reservation Updated!")
  end

  private

  def new_cost(passengers, class_level)
    total_cost = 0
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
