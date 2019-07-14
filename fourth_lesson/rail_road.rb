class RailRoad
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def create_station(name)
    stations << Station.new(name)
  end

  def create_route(start_point, end_point)
    routes << Route.new(start_point, end_point)
  end

  def create_train(number, type)
    case type
    when :cargo
      trains << CargoTrain.new(number)
    when :passenger
      trains << PassengerTrain.new(number)
    else
      "Can't recognize #{type} type"
    end
  end

  def create_wagon(type)
    case type
    when :cargo
      wagons << CargoWagon.new
    when :passenger
      wagons << PassengerWagon.new
    else
      "Can't recognize #{type} type"
    end
  end

  def seed
    # creating stations
    (1..5).to_a.each { |i| create_station("station #{i}") }

    # creating route
    route = create_route(stations.first, stations.last).first

    # filling route
    stations.each do |station|
      next if [stations.first, stations.last].include?(station)

      route.add_station(station)
    end
    # creating passenger train
    passenger_train = create_train(533, :passenger).first
    passenger_train.choose_route(route)
    # creating passenger wagons
    (1..10).to_a.each { create_wagon(:passenger) }
    # filling passenger train
    wagons.each { |wagon| passenger_train.add_wagon(wagon) }

  end

  def info
    puts stations
    puts ''
    puts routes
    puts ''
    puts trains
    puts ''
    puts wagons
    puts ''
  end
end