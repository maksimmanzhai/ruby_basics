class PassengerCarriage < Carriage
  attr_reader :seats

  def initialize(seats, company)
    @type = 'passenger'
    @seats = seats
    @company = company
  end
end
