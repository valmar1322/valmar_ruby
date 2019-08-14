class PassengerWagon < Wagon
  WRONG_CAPACITY = 'Количество мест должно быть >= 20'

  def initialize(seats_count)
    @occupied_seats = 0
    super(seats_count)
    validate!
  end

  def wrong_capacity
    WRONG_CAPACITY
  end

  def to_s
    "Общее число мест в вагоне: #{capacity}, занятых мест: #{occupied_capacity}, свободных мест: #{remaining_space}"
  end
end
