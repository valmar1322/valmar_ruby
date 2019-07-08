class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_freight_count
    trains.count { |train| train.type == 'freight' }
  end

  def get_passenger_count
     trains.count{|train| train.type == 'passenger'}
  end
end