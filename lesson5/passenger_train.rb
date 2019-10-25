class PassengerTrain < Train
  include InstanceCounter

  def initialize(number, company)
    super
    self.register_instance
    @type = 'passenger'
  end
end
