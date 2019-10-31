class CargoCarriage < Carriage
  attr_reader :capacity

  def initialize(capacity, company)
    @type = 'cargo'
    @capacity = capacity
    @company = company
  end
end
