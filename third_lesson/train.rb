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
    @speed == 0
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

  def get_current_station
    @route.station_list[@current_station]
  end

  def get_next_station
    @route.station_list.fetch(@current_station + 1, 'Route is ended')
  end

  def get_prev_station
    @route.station_list.fetch(@current_station - 1, 'Route is just started')
  end
end
