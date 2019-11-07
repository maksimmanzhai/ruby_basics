# frozen_string_literal: true

# class for creating Passenger Trains
class PassengerTrain < Train
  def initialize(number, company)
    super
    @type = 'passenger'
  end
end
