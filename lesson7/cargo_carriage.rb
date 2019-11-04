class CargoCarriage < Carriage
  attr_reader :type, :capacity

  def initialize(capacity, company)
    super
    @type = 'cargo'
    @capacity = capacity
    @free_capacity = capacity
    @reserved_capacity = 0
    @company = company
  end

  def reserve_capacity(value)
    raise 'There is no free capacity in the selected car' if @free_capacity <= 0
    @reserved_capacity += value
    @free_capacity -= value
  end

  def count_reserved_capacity
    @reserved_capacity
  end

  def count_free_capacity
    @free_capacity
  end

end
