class PassengerTrain < Train
  def initialize(number, company)
    super
    @type = 'passenger'
  end
end
