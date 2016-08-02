module FormHelper
  def fill_form_for_flight_search(flight)
    depart_airport = "#{flight.from_airport.name}"\
                     " (#{flight.from_airport.airport_code})"
    arrive_airport = "#{flight.to_airport.name}"\
                     " (#{flight.to_airport.airport_code})"
    select(depart_airport, from: "departs")
    select(arrive_airport, from: "arrives")
    select("Economy", from: :grade)
    page.execute_script("$('.ui.basic.blue.button').click()")
  end

  def fill_incomplete_form_for_flight_search
    select("Economy", from: :grade)
    select("1", from: :adults)
    select("1", from: :infants)
    select("1", from: :children)
    page.execute_script("$('.ui.basic.blue.button').click()")
  end

  def fill_form_for_sign_up
    password = Faker::Internet.password
    fill_in :first_name, with: Faker::Name.name
    fill_in :last_name, with: Faker::Name.name
    fill_in :email, with: Faker::Internet.email
    fill_in :phone, with: Faker::PhoneNumber.phone_number
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    page.execute_script("$('.ui.basic.blue.button').click()")
  end

  def fill_incomplete_form_for_sign_up
    password = Faker::Internet.password
    fill_in :first_name, with: Faker::Name.name
    fill_in :last_name, with: Faker::Name.name
    fill_in :email, with: "abc.com"
    fill_in :phone, with: Faker::PhoneNumber.phone_number
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    page.execute_script("$('.ui.basic.blue.button').click()")
  end

  def fill_form_for_booking
    fill_in 'adult__first_name', with: Faker::Name.name
    fill_in 'adult__last_name', with: Faker::Name.name
    fill_in 'adult__email', with: Faker::Internet.email
    page.execute_script("$('.ui.basic.blue.button').click()")
  end

  def fill_incomplete_form_for_booking
    fill_in 'adult__first_name', with: Faker::Name.name
    fill_in 'adult__last_name', with: ""
    page.execute_script("$('.ui.basic.blue.button').click()")
  end
end
