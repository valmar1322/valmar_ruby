class CargoWagon < Wagon
  attr_reader :carrying, :loaded_cargo

  ZERO_CARRYING = 'Грузоподъемность должна быть не меньше нуля'

  def initialize(carrying)
    @carrying = carrying
    validate!
    @loaded_cargo = 0
  end

  def load_cargo(weight)
    @loaded_cargo += weight if remaining_space - weight >= 0
  end

  def remaining_space
    carrying - loaded_cargo
  end

  def to_s
    "Грузоподъемность вагона: #{carrying}, занято объема: #{loaded_cargo}"
  end

  private

  def validate!
    raise ZERO_CARRYING unless @carrying.positive?
  end
end
