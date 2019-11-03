class PassengerCarriage < Carriage
  attr_reader :type

  def initialize(value, company)
    super
    @type = 'passenger'
  end
end
