class CargoTrain < Train
  def initialize(number, company)
    super
    @type = 'cargo'
  end
end
