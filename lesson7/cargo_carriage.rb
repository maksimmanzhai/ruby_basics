class CargoCarriage < Carriage
  attr_reader :type

  def initialize(value, company)
    super
    @type = 'cargo'
  end
end
