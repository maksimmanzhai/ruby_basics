class PassengerCarriage < Carriage
  attr_reader :seats

  def initialize(seats)
    @type = 'passenger'
    @seats = seats
  end
end
