# frozen_string_literal: true

# class for creating cargo trains
class CargoTrain < Train
  def initialize(number, company)
    super
    @type = 'cargo'
  end
end
