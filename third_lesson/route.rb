class Route
  attr_reader :start_point, :end_point, :station_list

  def initialize(start_point, end_point)
    @start_point = start_point
    @end_point = end_point
    @station_list = []
  end

  def add_station(station)
    @station_list << station
  end

  def remove_station(station)
    @station_list.delete(station)
  end

  def info
    print "#{start_point} -> "
    @station_list.each { |station| print "#{station.name} -> " }
    print "#{end_point}"
  end
end
