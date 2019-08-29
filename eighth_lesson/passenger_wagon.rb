# frozen_string_literal: true

class PassengerWagon < Wagon
  WRONG_CAPACITY = 'Количество мест должно быть >= 20'
  MIN_CAPACITY = 20

  def initialize(count_seats)
    super(count_seats)
    @occupied_seats = 0
  end

  def load_entity
    super(1)
  end

  def to_s
    "Общее число мест в вагоне: #{capacity},
    занятых мест: #{occupied_capacity},
    свободных мест: #{remaining_space}"
  end

  protected

  def min_capacity
    MIN_CAPACITY
  end

  def wrong_capacity
    WRONG_CAPACITY
  end
end
