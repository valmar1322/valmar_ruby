class Route
  attr_reader :station_list

  def initialize(start_point, end_point)
    @station_list = [start_point, end_point]
  end

  def add_station(station)
    @station_list << station
  end

  def remove_station(station)
    @station_list.delete(station)
  end

  def info
    @station_list.each { |station| print "#{station.name} -> " }
  end
end
