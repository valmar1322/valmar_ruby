load './train.rb'
load './route.rb'
load './station.rb'

freight_train1 = Train.new(113, 'freight', 12)
passenger_train1 = Train.new(553, 'passenger', 23)
passenger_train2 = Train.new(554, 'passenger', 23)


station1 = Station.new('Tomsk')
station2 = Station.new('Moscow')
station3 = Station.new('Novosibirsk')
station4 = Station.new('Abakan')
station5 = Station.new('Sankt-Peterburg')

route1 = Route.new(station1, station5)
route1.add_station(station2)
route1.add_station(station3)
route1.add_station(station4)

passenger_train1.choose_route(route1)

route1.info



puts ''
puts passenger_train1.count_carriages
puts passenger_train1.type
puts passenger_train1.number
puts passenger_train1.current_station.trains.first.number
puts station1.trains.first == passenger_train1