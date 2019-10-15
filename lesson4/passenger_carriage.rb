class PassengerCarriage < Carriage
  attr_reader :seats, :type

  def initialize(seats)
    @type = 'passenger'
    @seats = seats
  end
end
