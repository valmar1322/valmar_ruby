class CargoWagon < Wagon
  WRONG_CAPACITY = 'Грузоподъемность должна быть >= 1'
  MIN_CAPACITY = 1

  def initialize(carrying)
    super(carrying)
    @loaded_cargo = 0
  end

  def wrong_capacity
    WRONG_CAPACITY
  end

  def to_s
    "Грузоподъемность вагона: #{capacity}, занято объема: #{occupied_capacity}"
  end

  protected

  def min_capacity
    MIN_CAPACITY
  end

  def wrong_capacity
    WRONG_CAPACITY
  end
end
