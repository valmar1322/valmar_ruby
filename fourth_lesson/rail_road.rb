class RailRoad
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
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

    puts 'Введите номер(название) поезда: '
    train_number = gets.chomp

    create_train!(train_number, type)
  end

  def create_station
    puts 'Введите название станции: '
    station_name = gets.chomp

    create_station!(station_name)
  end

  def manage_routes
    puts 'a - Создать маршрут'
    puts 'b - Добавить станцию'
    puts 'c - Удалить станцию'

    choice = gets.chomp.downcase

    case choice
    when 'a'
      stations_info
      puts 'Выберите начальную станцию: '
      start_station = stations[gets.to_i]

    when 'b'
    when 'c'
    else
      puts 'Неправильный ввод'
    end
  end

  def stations_info
    stations.each.with_index { |station, index| puts "#{index} - #{station}"}
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
      when 10
        break
      else
        puts 'Неправильный ввод'
      end
    end

  end

  private

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

  def create_wagon!(type)
    case type
    when :cargo
      wagons << CargoWagon.new
    when :passenger
      wagons << PassengerWagon.new
    else
      "Can't recognize #{type} type"
    end
  end
end