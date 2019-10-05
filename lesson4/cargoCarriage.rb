class CargoCarriage < Carriage
  attr_reader :capacity, :type

  def initialize(capacity)
    @type = 'cargo'
    @capacity = capacity
  end
end
