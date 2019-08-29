# frozen_string_literal: true

class RailRoad
  attr_reader :stations, :routes, :trains

  METHODS = {
    1 => :create_train, 2 => :create_station, 3 => :manage_routes,
    4 => :add_route_to_train, 5 => :add_wagon_to_train,
    6 => :remove_wagon_from_train, 7 => :manage_trains, 8 => :trains_info,
    9 => :stations_info, 10 => :trains_of_station, 11 => :wagons_of_train,
    12 => :manage_wagons
  }.freeze

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def run
    loop do
      print_menu
      method_index = gets.to_i
      send METHODS[method_index] || break
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
    puts '3  -  Управление маршрутом'
    puts '4  -  Назначить маршрут поезду'
    puts '5  -  Добавить вагон к поезду'
    puts '6  -  Отцепить вагон от поезда'
    puts '7  -  Управление движением поезда'
    puts '8  -  Список всех поездов'
    puts '9  -  Список всех станций'
    puts '10 -  Список поездов на станции'
    puts '11 -  Список вагонов поезда'
    puts '12 -  Занять место или объем в вагоне'
    puts 'Для выхода нажмите любую другую клавишу'
  end

  def create_train
    puts '1 - Пассажирский поезд'
    puts '2 - Грузовой поезд'

    choice = gets.to_i

    type = case choice
           when 1 then :passenger
           when 2 then :cargo
           else
             :passenger
          end

    begin
      puts 'Введите номер(название) поезда:'
      train_number = gets.chomp
      create_train!(train_number, type)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts 'Поезд успешно создан!'
    info_train(trains.last)
  end

  def create_station
    begin
      puts 'Введите название станции:'
      station_name = gets.chomp
      create_station!(station_name)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts 'Станция успешно создана!'
    info_station(stations.last)
  end

  def manage_routes
    puts '1 - Создать маршрут'
    puts '2 - Добавить станцию'
    puts '3 - Удалить станцию'

    choice = gets.to_i

    case choice
    when 1 then create_route
    when 2 then add_station_to_route
    when 3 then delete_station_from_route
    else
      puts 'Неправильный ввод'
    end
  end

  def create_route
    if stations.size < 2
      puts 'Для создания маршрута необходимо создать как минимум две станции'
      return
    end

    begin
      stations_info
      puts 'Выберите начальную станцию:'
      start_station = select_from_array(stations)
      puts 'Выберите конечную станцию:'
      end_station = select_from_array(stations)

      create_route!(start_station, end_station)
    rescue RuntimeError => e
      puts e.message
      puts 'Некорректный ввод, выберите правильные индексы'
      retry
    end
    puts "Маршрут создан, его индекс #{routes.size}"
  end

  def add_station_to_route
    return unless relevant?(routes)

    routes_info
    puts 'Выберите маршрут:'
    route = select_from_array(routes)
    return if route.nil?

    stations_info
    puts 'Выберите станцию для добавления:'
    station = select_from_array(stations)
    return if station.nil?

    route.add_station(station)
    puts 'Станция успешно добавлена. Маршрут выглядит следующим образом:'
    puts route.info
  end

  def delete_station_from_route
    return unless relevant?(routes)

    routes_info
    puts 'Выберите маршрут:'
    route = select_from_array(routes)

    return if route.nil?

    stations_info(route.stations)
    puts 'Выберите станцию для удаления:'
    station = select_from_array(route.stations)

    return if station.nil?

    route.remove_station(station)
    puts 'Станция удалена. Маршрут выглядит следующим образом:'
    puts route.info
  end

  def add_route_to_train
    return unless relevant_all?(routes, trains)

    trains_info
    puts 'Выберите поезд:'
    train = select_from_array(trains)

    return if train.nil?

    routes_info
    puts 'Выберите маршрут'
    route = select_from_array(routes)
    return if route.nil?

    train.choose_route(route)
  end

  def add_wagon_to_train
    return unless relevant?(trains)

    trains_info
    puts 'Выберите поезд:'
    train = select_from_array(trains)

    return if train.nil?

    begin
      if train.is_a?(PassengerTrain)
        create_passenger_wagon(train)
      elsif train.is_a?(CargoTrain)
        create_cargo_wagon(train)
      end
      puts "Вагон успешно добавлен к поезду №#{train.number}"
    rescue RuntimeError => e
      puts e.message
    end

    puts train.wagons
  end

  def remove_wagon_from_train
    return unless relevant?(trains)

    trains_info
    puts 'Выберите поезд:'
    train = select_from_array(trains)

    return if train.nil? || train.empty?

    wagons_info(train)
    puts 'Выберите вагон для удаления: '
    wagon = select_from_array(train.wagons)
    return if wagon.nil?

    train.remove_wagon(wagon)
    puts 'Вагон успешно удален, поезд выглядит следующим образом:'
    wagons_info(train)
  end

  def manage_trains
    return unless relevant?(trains)

    trains_info
    puts 'Выберите поезд:'
    train = select_from_array(trains)

    return if train.nil?

    show_current_position(train)
    unless train.next_station.nil? && train.prev_station.nil?
      puts "следующая станция #{train.next_station.name}"
      puts "предыдущая станция #{train.prev_station.name}"
    end

    movement_control(train)
  end

  def movement_control(train)
    puts '1 - ехать вперед'
    puts '2 - ехать назад'

    choice = gets.to_i

    case choice
    when 1 then train.move_forward
    when 2 then train.move_backward
    else
      puts 'Неверный ввод, выбран вариант "ехать вперед"'
      train.move_forward
    end
  end

  def stations_info(needle_stations = stations)
    puts ''
    puts 'Список доступных станций:'
    needle_stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
    puts ''
  end

  def trains_info
    puts ''
    puts 'Список доступных поездов: '
    trains.each.with_index(1) { |train, index| puts "#{index} - #{train}" }
    puts ''
  end

  def routes_info
    puts ''
    puts 'Список доступных направлений:'
    routes.each.with_index(1) { |route, index| puts "#{index} #{route.name}" }
    puts ''
  end

  def trains_of_station
    stations_info
    puts 'Выберите станцию: '
    needle_station = select_from_array(stations)

    return if needle_station.nil?

    needle_station.each_train { |train| puts train }
    puts ''
  end

  def wagons_of_train
    trains_info
    puts 'Выберите поезд: '
    needle_train = select_from_array(trains)

    return if needle_train.nil?

    needle_train.each_wagon { |wagon, index| puts "#{index} вагон: #{wagon}" }
  end

  def manage_wagons
    return unless relevant?(trains)

    trains_info
    puts 'Для управления выгонами выберите поезд: '
    needle_train = select_from_array(trains)

    return if needle_train.nil? || needle_train.empty?

    wagons_info(needle_train)
    puts 'Выберите вагон: '
    needle_wagon = select_from_array(needle_train.wagons)

    return if needle_wagon.nil?

    begin
      if needle_wagon.is_a?(PassengerWagon)
        needle_wagon.load_entity
        puts needle_wagon
      elsif needle_wagon.is_a?(CargoWagon)
        puts "Свободный объем для загрузки: #{needle_wagon.remaining_space}"
        puts 'Введите объем для загрузки: '
        loaded_cargo = gets.to_i
        needle_wagon.load_entity(loaded_cargo)
      end
    rescue RuntimeError => e
      puts e.message
    end
  end

  def select_from_array(array)
    index = gets.to_i - 1
    return if index.negative?

    array[index]
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

  def create_passenger_wagon(train)
    puts 'Введите доступное количество мест в вагоне: '
    count_seats = gets.to_i
    train.add_wagon(PassengerWagon.new(count_seats))
  end

  def create_cargo_wagon(train)
    puts 'Введите доступную грузоподъемность для вагона: '
    carrying = gets.to_i
    train.add_wagon(CargoWagon.new(carrying))
  end

  def show_current_position(train)
    puts "Поезд под номером #{train.number}
    находится на #{train.current_station.name} "
  end

  def wagons_info(train)
    puts "Список доступных вагонов для поезда #{train.number}: "
    train.each_wagon { |wagon, index| puts "#{index} вагон: #{wagon}" }
  end

  def info_train(train)
    puts "Номер поезда: #{train.number}"
    puts "Тип поезда: #{train.type}"
    puts ''
  end

  def info_station(station)
    puts "Название станции: #{station.name}"
    puts ''
  end

  def relevant?(array)
    !array.empty?
  end

  def relevant_all?(*args)
    args.all? { |arg| relevant? arg }
  end
end
