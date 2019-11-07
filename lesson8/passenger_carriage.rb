# frozen_string_literal: true

# class for creating Passenger Carriages
class PassengerCarriage < Carriage
  attr_reader :type, :seats

  def initialize(seats, company)
    super
    @type = 'passenger'
    @seats = seats
    @free = seats
    @reserved = 0
    @company = company
  end

  def reserve_seats
    raise 'There is no free seats in the selected car' if @free <= 0

    @reserved += 1
    @free -= 1
  end
end
