class PassengerTrain < Train
  def add_wagon(wagon)
    return unless attachable_wagon?(wagon)

    super(wagon)
  end

  private

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end
end