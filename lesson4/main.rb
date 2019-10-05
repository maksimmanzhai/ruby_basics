require './carriage.rb'
require './train.rb'
require './cargoCarriage.rb'
require './cargoTrain.rb'
require './passengerCarriage.rb'
require './passengerTrain.rb'
require './route.rb'
require './station.rb'


class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end
end

menu = Main.new

p train1 = CargoTrain.new(1)
p train2 = PassengerTrain.new(2)
train1.up_speed(90)
p train1
p cargoCar = CargoCarriage.new(100)
p passCar = PassengerCarriage.new(20)
p train1.coupling_carriages(cargoCar)
p train1.coupling_carriages(cargoCar)
p train1