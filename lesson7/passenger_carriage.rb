class PassengerCarriage < Carriage
  attr_reader :type, :seats, :free_seats, :reserved_seats

  def initialize(seats, company)
    super
    @type = 'passenger'
    @seats = seats
    @free_seats = seats
    @reserved_seats = 0
    @company = company
  end

  def reserve_seats
    raise 'There is no free seats in the selected car' if @free_seats <= 0
    @reserved_seats += 1
    @free_seats -= 1
  end
  
  def count_reserved_seats
    @reserved_seats
  end

  def count_free_seats
    @free_seats
  end
end
