module FormHelper
  def fill_form_for_flight_search
    select("Benin Airport (BNI)", from: 'departs')
    select("Lagos Murtala Muhammed Airport (LOS)", from: 'arrives')
    select('Economy', from: :grade)
    fill_in 'date', with: "07-06-2016"
    select('1', from: :adults)
    select('1', from: :infants)
    select('1', from: :children)
    page.execute_script("$('.ui.basic.blue.button').click()")
  end

  def fill_form_for_booking
    fill_in :first_name, with: Faker::Name.name
    fill_in :last_name, with: Faker::Name.name
    fill_in :email, with: Faker::Internet.email
    fill_in "adult__first_name", with: Faker::Name.name
    fill_in "adult__last_name", with: Faker::Name.name
    fill_in "child__first_name", with: Faker::Name.name
    fill_in "child__last_name", with: Faker::Name.name
    fill_in "infant__first_name", with: Faker::Name.name
    fill_in "infant__last_name", with: Faker::Name.name
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

end