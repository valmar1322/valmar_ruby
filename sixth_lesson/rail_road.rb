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
      when 1 then create_train
      when 2 then create_station
      when 3 then manage_routes
      when 4 then add_route_to_train
      when 5 then add_wagon_to_train
      when 6 then remove_wagon_from_train
      when 7 then manage_trains
      when 8 then trains_info
      when 9 then stations_info
      when 10 then break
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
    puts '1 - Пассажирский поезд'
    puts '2 - Грузовой поезд'

    choice = gets.to_i

    case choice
    when 1 then type = :passenger
    when 2 then type = :cargo
    else
      type = :passenger
      puts "Неправильный ввод, по умолчанию выбран: #{type}"
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
    puts "Маршрут создан, вы можете обращаться к нему по индексу #{routes.size}"
  end

  def add_station_to_route
    unless relevant?(routes)
      puts 'Нет созданных маршрутов'
      return
    end

    routes_info
    puts 'Выберите маршрут:'
    route = select_from_array(routes)
    if route.nil?
      puts 'Такого маршрута не существует'
      return
    end

    stations_info
    puts 'Выберите станцию для добавления:'
    station = select_from_array(stations)
    if station.nil?
      puts 'Такой станции не существует'
      return
    end

    route.add_station(station)
    puts 'Станция успешно добавлена. Маршрут выглядит следующим образом:'
    puts route.info
  end

  def delete_station_from_route
    unless relevant?(routes)
      puts 'Нет созданных маршрутов'
      return
    end

    routes_info
    puts 'Выберите маршрут:'
    route = select_from_array(routes)

    return if route.nil?

    stations_info(route.stations)
    puts 'Выберите станцию для удаления:'
    station = select_from_array(route.stations)

    if station.nil?
      puts 'Такой станции не существует'
      return
    end

    route.remove_station(station)
    puts 'Станция удалена. Маршрут выглядит следующим образом:'
    puts route.info
  end

  def add_route_to_train
    unless relevant_all?(routes, trains)
      puts 'Вы должны создать маршрут и поезд'
      return
    end

    trains_info
    puts 'Выберите поезд:'
    train = select_from_array(trains)

    return if train.nil?

    routes_info
    puts 'Выберите маршрут'
    route = select_from_array(routes)
    if route.nil?
      puts 'Такого маршрута не существует'
      return
    end

    train.choose_route(route)
  end

  def add_wagon_to_train
    unless relevant?(trains)
      puts 'Вы должны создать поезд'
      return
    end
    trains_info
    puts 'Выберите поезд:'
    train = select_from_array(trains)

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
    unless relevant?(trains)
      puts 'Вы должны создать поезд'
      return
    end
    trains_info
    puts 'Выберите поезд:'
    train = select_from_array(trains)

    if train.nil?
      puts 'Такого поезда не существует'
      return
    end

    if train.empty?
      puts 'У данного поезда не осталось лишних вагонов'
      return
    end

    wagons_info(train)
    puts 'Выберите вагон для удаления: '
    wagon = select_from_array(train.wagons)
    return if wagon.nil?

    train.remove_wagon(wagon)
    puts "Вагон успешно удален, поезд под номером #{train.number} выглядит следующим образом: "
    wagons_info(train)
  end

  def manage_trains
    unless relevant?(trains)
      puts 'Вы должны создать поезд'
      return
    end
    trains_info
    puts 'Выберите поезд:'
    train = select_from_array(trains)

    return if train.nil?

    show_current_position(train)
    unless train.next_station.nil?
      puts "следующая станция #{train.next_station.name}"
    end
    unless train.prev_station.nil?
      puts "предыдущая станция #{train.prev_station.name}"
    end

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
    needle_stations.each.with_index(1) { |station, index| puts "#{index} - #{station.name}" }
    puts ''
  end

  def trains_info
    puts ''
    puts 'Список доступных поездов: '
    trains.each.with_index(1) { |train, index| puts "#{index} - №#{train.number}"}
    puts ''
  end

  def routes_info
    puts ''
    puts 'Список доступных направлений:'
    routes.each.with_index(1) { |route, index| puts "#{index} #{route.name}" }
    puts ''
  end

  def select_from_array(array)
    index = gets.to_i - 1
    return if index.negative?

    array[index]
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

  def show_current_position(train)
    puts "Поезд под номером #{train.number} находится на #{train.current_station.name} "
  end

  def wagons_info(train)
    puts "Список доступных вагонов для поезда #{train.number}: "
    train.wagons.each.with_index(1) { |wagon, index| puts "#{wagon} - #{index}" }
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
