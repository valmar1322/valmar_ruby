class Train
  attr_reader :speed, :count_carriages

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

  def accept_route(route)
    @route = route
    @route.start_point.take_train(self)
  end


end
