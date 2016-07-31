module ParamsHelper
  def flight_params
    {
      format: :js,
      departs: "Abuja Intenational Airport (ABV)",
      arrives: "Benin Airport (BNI)",
      grade: "Economy",
      adults: "1",
      children: "1",
      infants: "1",
      date: "2016-06-27"
    }
  end

  def booking_params
    {
      format: :js,
      adult: [{ first_name: "John", last_name: "Doe", email: "a@gmail.com" }],
      child: [{ first_name: "Mercy", last_name: "Johnson" }],
      infant: [{ first_name: "Michelle", last_name: "Obama" }]
    }
  end
end