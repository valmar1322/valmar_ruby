# frozen_string_literal: true

require_relative 'producer'
require_relative 'instance_counter'
require_relative 'validator'
require_relative 'accessors'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'station'
require_relative 'route'
require_relative 'rail_road'

# RailRoad.new.run

train1 = Train.new('533-A1', :cargo)
train2 = Train.new('488-B4', :passenger)

# Attribute Accessor with history work test

train2.number = '355-31'
train2.number = '355-ac'
train2.number = '555-65'

puts 'train2 number history: '
puts train2.number_history
puts ''

# Strong Parameter work test
begin
  train1.speed = '35'
rescue TypeError => e
  puts e.message
  train1.speed = 45
end

puts train1
puts "Скорость: #{train1.speed}"

# Validator test

train3 = Train.new('533', :cargo)
puts train3.valid?

train3.number = '533-bb'
puts train3.valid?

train3.type = ''
puts train3.valid?

train3.type = :cargo
puts train3.valid?

# 1.upto(5) do
#   train1.add_wagon PassengerWagon.new(25)
# end
# station.take_train(train1)
# station.take_train(train2)

# station.each_train { |train| puts train }
# train1.each_wagon do |wagon|
#   1.upto(26) { wagon.load_entity }
#   puts "free spaces: #{wagon.remaining_space}"
# end

# cargo_wagon = CargoWagon.new(500)
# cargo_wagon.load_entity(300)
# cargo_wagon.load_entity(150)
# cargo_wagon.load_entity(150)
# puts cargo_wagon.occupied_capacity
