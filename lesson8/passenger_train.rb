# frozen_string_literal: true

# class for creating passenger trains
class PassengerTrain < Train
  def initialize(number, company)
    super
    @type = 'passenger'
  end
end
