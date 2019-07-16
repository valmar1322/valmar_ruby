class RailRoad
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def run
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
      when 6
        remove_wagon_from_train
      when 7
        manage_trains
      when 8
        trains_info
      when 9
        stations_info
      when 10
        break
      else
        puts 'Неправильный ввод'
      end
    end

  end

  private

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
    puts '8  -  Список поездов'
    puts '9  -  Список станций'
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

    if train_number.empty?
      puts 'Название не может быть пустым.'
      return
    end

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
    if stations.size < 2
      puts 'Для создания маршрута необходимо создать как минимум две станции'
      return
    end

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

    routes_info
    puts 'Выберите маршрут'
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
    trains_info
    puts 'Выберите поезд:'
    train = require_train

    if train.nil?
      puts 'Такого поезда не существует'
      return
    end

    if train.empty?
      puts 'У данного поезда не осталось лишних вагонов'
      return
    end

    train.wagons_info
    puts 'Выберите вагон для удаления: '
    wagon = require_wagon(train)
    return if wagon.nil?

    train.remove_wagon(wagon)
    puts "Вагон успешно удален, поезд под номером #{train.number} выглядит следующим образом: "
    train.wagons_info
  end

  def manage_trains
    trains_info
    puts 'Выберите поезд:'
    train = require_train

    return if train.nil?

    puts "Поезд под номером #{train.number} находится на #{train.current_station.name} "
    unless train.next_station.nil?
      puts "следующая станция #{train.next_station.name}"
    end
    unless train.prev_station.nil?
      puts "предыдущая станция #{train.prev_station.name}"
    end

    puts 'a - ехать вперед'
    puts 'b - ехать назад'

    choice = gets.chomp.downcase

    case choice
    when 'a'
      train.move_forward
    when 'b'
      train.move_backward
    else
      puts 'Неверный ввод, выбран вариант "ехать вперед"'
      train.move_forward
    end
  end

  def stations_info
    puts ''
    puts 'Список доступных станций:'
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    puts ''
  end

  def trains_info
    puts ''
    puts 'Список доступных поездов: '
    trains.each.with_index { |train, index| puts "#{index} - №#{train.number}"}
    puts ''
  end

  def routes_info
    puts ''
    puts 'Список доступных направлений:'
    routes.each.with_index { |route, index| puts "#{index} #{route.name}" }
    puts ''
  end

  def require_route
    needle_route = routes[gets.to_i]
    if needle_route.nil?
      puts 'Неверный ввод: такого маршрута не существует'
      return nil
    end
    needle_route
  end

  def require_station
    needle_station = stations[gets.to_i]

    if needle_station.nil?
      puts 'Неверный ввод: такой станции не существует'
      return nil
    end
    needle_station
  end

  def require_train
    needle_train = trains[gets.to_i]
    if needle_train.nil?
      puts 'Неверный ввод: такого поезда не существует'
      return nil
    end
    needle_train
  end

  def require_wagon(train)
    needle_wagon = train.wagons[gets.to_i]
    if needle_wagon.nil?
      puts "Неверный ввод: вагон с номером #{index} для поезда с номером #{train.number}"
      return nil
    end
    needle_wagon
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
