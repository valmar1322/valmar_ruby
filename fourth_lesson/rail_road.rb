class RailRoad
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def info
    puts stations
    puts ''
    puts routes
    puts ''
    puts trains
  end

  def print_menu
    puts '1  -  Создать поезд'
    puts '2  -  Создать станцию'
    puts '3  -  Управление маршрутом(создать, добавить станцию, удалить станцию)'
    puts '4  -  Назначить маршрут поезду'
    puts '5  -  Добавить вагон к поезду'
    puts '6  -  Отцепить вагон от поезда'
    puts '7  -  Управление движением поезда'
    puts '8  -  Список станций'
    puts '9  -  Список поездов'
    puts '10 -  Выход'
  end

  def create_train
    puts 'a - Пассажирский поезд'
    puts 'b - Грузовой поезд'

    choice = gets.chomp.downcase

    case choice
    when 'a'
      type = :passenger
    when 'b'
      type = :cargo
    else
      type = :passenger
      puts "Неправильный ввод, по умолчанию выбран: #{type}"
    end

    puts 'Введите номер(название) поезда:'
    train_number = gets.chomp

    create_train!(train_number, type)
  end

  def create_station
    puts 'Введите название станции:'
    station_name = gets.chomp
    return if station_name.empty?

    create_station!(station_name)
  end

  def manage_routes
    puts 'a - Создать маршрут'
    puts 'b - Добавить станцию'
    puts 'c - Удалить станцию'

    choice = gets.chomp.downcase

    case choice
    when 'a'
      create_route
    when 'b'
      add_station_to_route
    when 'c'
      delete_station_from_route
    else
      puts 'Неправильный ввод'
    end
  end

  def create_route
    stations_info
    puts 'Выберите начальную станцию:'
    start_station = require_station
    puts 'Выберите конечную станцию:'
    end_station = require_station

    return if start_station.nil? || end_station.nil?

    create_route!(start_station, end_station)
    route_index = routes.size - 1
    puts "Маршрут создан, вы можете обращаться к нему по индексу #{route_index}"
  end

  def add_station_to_route
    routes_info
    puts 'Выберите маршрут:'
    route = require_route
    return if route.nil?

    stations_info
    puts 'Выберите станцию для добавления:'
    station = require_station
    return if station.nil?

    route.add_station(station)
    puts 'Станция успешно добавлена. Маршрут выглядит следующим образом:'
    route.info
  end

  def delete_station_from_route
    routes_info
    puts 'Выберите маршрут:'
    route = require_route

    return if route.nil?

    stations_info
    puts 'Выберите станцию для удаления:'
    station = require_station
    return if station.nil?

    route.remove_station(station)
    puts 'Станция удалена. Маршрут выглядит следующим образом:'
    route.info
  end

  def add_route_to_train
    trains_info
    puts 'Выберите поезд:'
    train = require_train

    return if train.nil?

    route = require_route
    return if route.nil?

    train.choose_route(route)
  end

  def add_wagon_to_train
    trains_info
    puts 'Выберите поезд:'
    train = require_train

    return if train.nil?

    if train.is_a?(PassengerTrain)
      train.add_wagon(PassengerWagon.new)
    elsif train.is_a?(CargoTrain)
      train.add_wagon(CargoWagon.new)
    end

    puts "Вагон успешно добавлен к поезду №#{train.number}"
    puts train.wagons
  end

  def remove_wagon_from_train

  def stations_info
    puts 'Список доступных станций:'
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
  end

  def trains_info
    puts 'Список доступных поездов: '
    trains.each.with_index { |train, index| puts "#{index} - №#{train.number}"}
  end

  def routes_info
    puts 'Список доступных направлений:'
    routes.each.with_index { |route, index| puts "#{index} #{route.name}" }
  end

  def main_loop

    loop do
      print_menu
      input = gets.to_i
      case input
      when 1
        create_train
      when 2
        create_station
      when 3
        manage_routes
      when 4
        add_route_to_train
      when 5
        add_wagon_to_train
      when 10
        break
      else
        puts 'Неправильный ввод'
      end
    end

  end

  private

  def require_route
    needle_route = routes[gets.to_i]
    if needle_route.nil?
      puts 'Неверный ввод, такого маршрута не существует'
      return nil
    end
    needle_route
  end

  def require_station
    needle_station = stations[gets.to_i]

    if needle_station.nil?
      puts 'Неверный ввод, такой станции не существует'
      return nil
    end
    needle_station
  end

  def require_train
    needle_train = routes[gets.to_i]
    if needle_train.nil?
      puts 'Неверный ввод, такого поезда не существует'
      return nil
    end
    needle_train
  end

  def create_station!(name)
    stations << Station.new(name)
  end

  def create_route!(start_point, end_point)
    routes << Route.new(start_point, end_point)
  end

  def create_train!(number, type)
    case type
    when :cargo
      trains << CargoTrain.new(number)
    when :passenger
      trains << PassengerTrain.new(number)
    else
      "Can't recognize #{type} type"
    end
  end
end