load './train.rb'
load './route.rb'
load './station.rb'

# start_station = Station.new('start station')
# end_station   = Station.new('end station')
# some_station = Station.new('first after start station')
#
# route = Route.new(start_station, end_station)
#
# route.add_station(some_station)
#
# route.remove_station(start_station)
# puts route.station_list

freight_train1 = Train.new(113, 'freight', 12)
passenger_train1 = Train.new(553, 'passenger', 23)
passenger_train2 = Train.new(554, 'passenger', 23)

puts freight_train1.current_station

tomsk = Station.new('Tomsk')
tomsk.take_train(freight_train1)
tomsk.take_train(passenger_train1)
tomsk.take_train(passenger_train2)
puts tomsk.passenger_count