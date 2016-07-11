require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  context '#welcome' do
    before(:each) { @user = create(:user) }
    let(:mail) { UserMailer.welcome(@user.id) }
    it 'renders the subject' do
      expect(mail.subject).to eq 'Welcome to FlySafe'
    end

    it "renders receiver's email address" do
      expect(mail.to).to eq [@user.email]
    end

    it "renders sender's email address" do
      expect(mail.from).to eq ['noreply@flysafe.com']
    end
  end

  context '#update_reservation' do
    before(:each) do
      @booking = create(:booking)
      @booking.flight.route.update(arriving_airport: create(:arriving_airport))
    end

    let(:mail) { UserMailer.update_reservation(@booking.user, @booking.id) }
    it 'renders the subject' do
      expect(mail.subject).to eq 'Fly Safe. Booking Reservation Updated!'
    end

    it "renders receiver's email address" do
      expect(mail.to).to eq [@booking.user.email]
    end

    it "renders sender's email address" do
      expect(mail.from).to eq ['noreply@flysafe.com']
    end
  end

  context '#delete_reservation' do
    before(:each) do
      @booking = create(:booking)
      @booking.flight.route.update(arriving_airport: create(:arriving_airport))
    end

    let(:mail) { UserMailer.delete_reservation(@booking.user, @booking.id) }
    it 'renders the subject' do
      expect(mail.subject).to eq 'Fly Safe. Booking Reservation Cancelled!'
    end

    it "renders receiver's email address" do
      expect(mail.to).to eq [@booking.user.email]
    end

    it "renders sender's email address" do
      expect(mail.from).to eq ['noreply@flysafe.com']
    end
  end
end
