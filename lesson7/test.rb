station1 = Station.new('minsk')
station2 = Station.new('hrodna')
station3 = Station.new('vitebsk')
station4 = Station.new('mohilev')
station5 = Station.new('homel')
station6 = Station.new('brest')

train1 = CargoTrain.new('123 33', 'Flagstaff')
train2 = CargoTrain.new('452 14', 'Accessories')
train3 = CargoTrain.new('223 82', 'Iconic')
train4 = PassengerTrain.new('876 26', 'Pronto')
train5 = PassengerTrain.new('342 54', 'Simplified')

route1 = Route.new('minsk_mohilev', station1, station4)
route2 = Route.new('hrodna_brest', station2, station6)
route3 = Route.new('vitebsk_hrodna', station3, station2)
route4 = Route.new('mohilev_vitebsk', station4, station3)
route5 = Route.new('homel_minsk', station5, station1)
route6 = Route.new('brest_homel', station6, station5)

route1.add_station(station3)
route1.add_station(station4)
route2.add_station(station5)
route3.add_station(station1)

route1.delete_station(station4)

train1.set_route(route1)
train2.set_route(route2)
train3.set_route(route3)
train4.set_route(route4)
train5.set_route(route5)

carriage1 = CargoCarriage.new(123, 'lexx')
carriage2 = PassengerCarriage.new(40, 'lexx')

train1.coupling_carriages(carriage1)
train1.coupling_carriages(carriage2)