require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before(:all) do
    @booking = create(:booking)
    flight = create(:flight, :departing, :arriving)
    @booking.update(flight: flight)
  end

  context '#welcome' do
    before(:all) { @user = create(:user, email: "a@gmail.com") }
    let(:mail) { UserMailer.welcome(@user.id) }
    it "renders the subject" do
      expect(mail.subject).to eq "Welcome to FlySafe"
    end

    it "renders receiver's email address" do
      expect(mail.to).to eq [@user.email]
    end

    it "renders sender's email address" do
      expect(mail.from).to eq ["noreply@fly-safe.herokuapp.com"]
    end
  end

  context '#update_reservation' do
    let(:mail) { UserMailer.update_reservation(@booking.id) }
    it "renders the subject" do
      expect(mail.subject).to eq "Fly Safe. Booking Reservation Updated!"
    end

    it "renders receiver's email address" do
      expect(mail.to).to eq [@booking.user.email]
    end

    it "renders sender's email address" do
      expect(mail.from).to eq ["noreply@fly-safe.herokuapp.com"]
    end
  end

  context '#booking_success' do
    let(:mail) { UserMailer.booking_success(@booking.id) }
    it "renders the subject" do
      expect(mail.subject).to eq "Booking was successful"
    end

    it "renders receiver's email address" do
      expect(mail.to).to eq [@booking.user.email]
    end

    it "renders sender's email address" do
      expect(mail.from).to eq ["noreply@fly-safe.herokuapp.com"]
    end
  end

  context '#delete_reservation' do
    let(:mail) { UserMailer.delete_reservation(@booking.id) }
    it "renders the subject" do
      expect(mail.subject).to eq "Fly Safe. Booking Reservation Cancelled!"
    end

    it "renders receiver's email address" do
      expect(mail.to).to eq [@booking.user.email]
    end

    it "renders sender's email address" do
      expect(mail.from).to eq ["noreply@fly-safe.herokuapp.com"]
    end
  end
end
