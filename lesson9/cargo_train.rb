# frozen_string_literal: true

# class for creating Cargo Trains
class CargoTrain < Train
  def initialize(number, company)
    super
    @type = 'cargo'
  end
end
