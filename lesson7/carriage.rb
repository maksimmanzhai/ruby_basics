class Carriage
  include Company

  attr_reader :type, :value, :free_value, :reserved_value

  def initialize(value, company)
    @value = value
    @free_value = value
    @reserved_value = 0
    @company = company
  end

  def reserve_value
    raise 'There is no free space in the selected car' if @free_value <= 0
    @reserved_value += 1
    @free_value -= 1
  end

  def count_reserved_value
    @reserved_value
  end

  def count_free_value
    @free_value
  end
end
