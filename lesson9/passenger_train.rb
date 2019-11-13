# frozen_string_literal: true

# class for creating Passenger Trains
class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  
  def initialize(number, company)
    super
    @type = 'passenger'
  end
end
