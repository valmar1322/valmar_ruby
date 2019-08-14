class Wagon
  include Producer

  attr_reader :capacity, :occupied_capacity

  def initialize(capacity = 1)
    @capacity = capacity
    validate!
    @occupied_capacity = 0
  end

  def load_entity(quantity = 1)
    @occupied_capacity += quantity if remaining_space - quantity >= 0
  end

  def remaining_space
    capacity - occupied_capacity
  end

  def full?
    capacity == occupied_capacity
  end

  private

  def validate!
    raise wrong_capacity if capacity <= 0
  end
end
