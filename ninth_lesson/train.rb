# frozen_string_literal: true

class Train
  include Producer
  include InstanceCounter
  include Validator
  include Accessors

  NUMBER_FORMAT = /^\w{3}-?\w{2}$/i.freeze
  INVALID_FORMAT = 'Неправильный формат номера поезда. Формат:
                   "XXX-XX", где X - число или буква'

  attr_reader :wagons
  attr_accessor_with_history :number, :type
  strong_attr_accessor :speed, Integer

  validate :number, :format, /^\w{3}-?\w{2}$/i
  validate :type, :presence

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @speed = 0
    @type = type
    @wagons = []
    @@trains[number] = self
    register_instance
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

  def choose_route(route)
    @route = route
    @current_station = 0
    current_station.take_train(self)
  end

  def current_station
    @route.stations[@current_station]
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def prev_station
    return unless @current_station.positive?

    @route.stations.fetch(@current_station - 1, nil)
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

  def add_wagon(wagon)
    return if wagons.include?(wagon)

    @wagons << wagon
  end

  def remove_wagon(wagon)
    return if wagons.empty?

    wagons.delete(wagon)
  end

  def empty?
    wagons.empty?
  end

  def wagons_count
    wagons.size
  end

  def each_wagon
    wagons.each.with_index(1) { |wagon, index| yield(wagon, index) }
  end

  def to_s
    "Номер поезда: #{number}, тип: #{type}, количество вагонов: #{wagons_count}"
  end
end
