require_relative 'producer'
require_relative 'instance_counter'
require_relative 'validator'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'station'
require_relative 'route'
require_relative 'rail_road'

RailRoad.new.run

# station = Station.new('Tomsk')
# train1 = Train.new('533-A1', :cargo)
# train2 = Train.new('488-B4', :passenger)

# 1.upto(5) do
#   train1.add_wagon PassengerWagon.new(25)
# end
# station.take_train(train1)
# station.take_train(train2)

# station.each_train { |train| puts train }
# train1.each_wagon do |wagon|
#   1.upto(26) { wagon.load_entity }
#   puts "Свободных мест: #{wagon.remaining_space}"
# end

# cargo_wagon = CargoWagon.new(500)
# cargo_wagon.load_entity(300)
# cargo_wagon.load_entity(150)
# cargo_wagon.load_entity(150)
# puts cargo_wagon.occupied_capacity
