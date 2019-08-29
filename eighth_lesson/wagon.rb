# frozen_string_literal: true

class Wagon
  include Producer

  WRONG_CAPACITY = 'Вместимость вагона должна быть >= 0'
  NOT_ENOUGH_SPACE = 'Не хватает места размещения в вагоне'
  MIN_CAPACITY = 0

  attr_reader :capacity, :occupied_capacity

  def initialize(capacity)
    @capacity = capacity
    validate!
    @occupied_capacity = 0
  end

  def load_entity(quantity = 1)
    raise NOT_ENOUGH_SPACE if quantity > remaining_space

    @occupied_capacity += quantity
  end

  def remaining_space
    capacity - occupied_capacity
  end

  def full?
    capacity == occupied_capacity
  end

  protected

  def min_capacity
    MIN_CAPACITY
  end

  def wrong_capacity
    WRONG_CAPACITY
  end

  def validate!
    raise wrong_capacity if capacity < min_capacity
  end
end
