# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validator

  MIN_STATION_NAME_LENGTH = 3
  MAX_STATION_NAME_LENGTH = 25
  MIN_SYMBOLS = 'Название станции должно быть минимум 3 символа'
  MAX_SYMBOLS = 'Название станции должно быть не более 25 символов'

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

  def each_train
    trains.each { |train| yield(train) }
  end

  private

  def validate!
    raise MIN_SYMBOLS if name.length < MIN_STATION_NAME_LENGTH
    raise MAX_SYMBOLS if name.length > MAX_STATION_NAME_LENGTH
  end
end
