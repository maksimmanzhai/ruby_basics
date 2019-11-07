# frozen_string_literal: true

# class for creating cargo carriages
class CargoCarriage < Carriage
  attr_reader :type, :capacity

  def initialize(capacity, company)
    super
    @type = 'cargo'
    @capacity = capacity
    @free = capacity
    @reserved = 0
    @company = company
  end

  def reserve_capacity(value)
    raise 'There is no free capacity in the selected car' if @free <= 0

    @reserved += value
    @free -= value
  end
end
