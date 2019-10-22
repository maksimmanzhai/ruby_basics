class CargoCarriage < Carriage
  attr_reader :capacity

  def initialize(capacity)
    @type = 'cargo'
    @capacity = capacity
  end
end
