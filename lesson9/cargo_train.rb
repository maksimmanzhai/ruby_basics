# frozen_string_literal: true

# class for creating Cargo Trains
class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number, company)
    super
    @type = 'cargo'
  end
end
