class CargoTrain < Train
  include InstanceCounter

  def initialize(number, company)
    super
    self.register_instance
    @type = 'cargo'
  end
end
