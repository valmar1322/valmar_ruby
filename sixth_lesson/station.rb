class Station
  include InstanceCounter
  include Validator
  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_count(type)
    trains.count { |train| train.type == type }
  end

  private

  MIN_STATION_NAME_LENGTH = 3
  MAX_STATION_NAME_LENGTH = 25

  def validate!
    if name.length < MIN_STATION_NAME_LENGTH
      raise 'Название станции должно быть минимум 3 символа'
    end
    if name.length > MAX_STATION_NAME_LENGTH
      raise 'Station name should be no longer than 25 symbols'
    end
  end
end
