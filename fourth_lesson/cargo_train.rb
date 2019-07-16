class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
  end

  def add_wagon(wagon)
    return unless attachable_wagon?(wagon)

    super(wagon)
  end

  private

  def attachable_wagon?(wagon)
    wagon.is_a?(CargoWagon)
  end
end
