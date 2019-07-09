class Train
  attr_reader :speed, :count_carriages, :type

  def initialize(number, type, count_carriages)
    @number = number
    @type = type
    @count_carriages = count_carriages
    @speed = 0
  end

  def increase_speed(increment)
    @speed += increment
  end

  def stop
    @speed = 0
  end

  def stop?
    @speed.zero?
  end

  def add_carriage
    @count_carriages += 1 if stop?
  end

  def remove_carriage
    @count_carriages -= 1 if stop?
  end

  def choose_route(route)
    @route = route
    @route.station_list[0].take_train(self)
    @current_station = 0
  end

  def current_station
    @route.station_list[@current_station]
  end

  def next_station
    @route.station_list.fetch(@current_station + 1, false)
  end

  def prev_station
    @route.station_list.fetch(@current_station - 1, false)
  end

  def move_forward
    return false unless next_station

    current_station.send_train(self)
    next_station.take_train(self)
    @current_station += 1
  end

  def move_backward
    return false unless prev_station

    current_station.send_train(self)
    prev_station.take_train(self)
    @current_station -= 1
  end
end
