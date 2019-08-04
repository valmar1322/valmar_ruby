class Route
  include InstanceCounter
  include Validator
  attr_reader :stations, :name

  def initialize(start_point, end_point)
    @stations = [start_point, end_point]
    validate!
    @name = "#{start_point.name} - #{end_point.name}"
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station) unless stations.include?(station)
  end

  def remove_station(station)
    return if [stations.first, stations.last].include?(station)

    stations.delete(station)
  end

  def info
    info = ''
    stations.each { |station| info += "#{station.name} -> " }
    info
  end

  private

  def validate!
    raise 'All points should be Station objects' unless stations.all? { |station| station.is_a?(Station) }
  end
end
