class CargoWagon < Wagon
  WRONG_CAPACITY = 'Грузоподъемность должна быть не меньше нуля'

  def initialize(carrying)
    @loaded_cargo = 0
    super(carrying)
    validate!
  end

  def wrong_capacity
    WRONG_CAPACITY
  end

  def to_s
    "Грузоподъемность вагона: #{capacity}, занято объема: #{occupied_capacity}"
  end
end
