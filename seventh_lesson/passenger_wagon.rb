class PassengerWagon < Wagon
  attr_reader :seats_count, :occupied_seats

  MINIMUM_SEATS = 'Количество мест должно быть >= 20'

  def initialize(seats_count)
    @seats_count = seats_count
    validate!
    @occupied_seats = 0
    super()
  end

  def take_place
    @occupied_seats += 1 unless full?
  end

  def full?
    seats_count == occupied_seats
  end

  def free_seats
    seats_count - occupied_seats
  end

  def to_s
    "Общее число мест в вагоне: #{seats_count}, занятых мест: #{occupied_seats}, свободных мест: #{free_seats}"
  end

  private

  def validate!
    raise MINIMUM_SEATS if seats_count < 20
  end
end
