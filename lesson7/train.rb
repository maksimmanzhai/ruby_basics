# frozen_string_literal: true

# class train
class Train
  include Company
  include InstanceCounter

  @@trains = []

  attr_reader :number, :type, :speed, :carriages

  def initialize(number, company)
    @number = number
    @company = company
    @speed = 0
    @carriages = []
    validate!
    @@trains << self
    self.register_instance
  end

  def validate!
    raise "ERROR: Number of train can't be empty" if @number.empty?
    raise "ERROR: Number of train must be in the format XXX-XX" unless @number =~ /(\S{3}-\S{2}|\S{3}\s\S{2})/i
    raise "ERROR: Company can't be empty" if @company.empty?
    raise "ERROR: Company should be at least 2 symbols" if @company.length < 2
  end

  def coupling_carriages(carriage)
    if carriage.type == self.type
      @carriages << carriage
    end
  end

  def uncoupling_carriages
    @carriages.pop
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
    @route.start.add_train(self)
  end

  def move_forward
    return if next_station.nil?
    current_station.delete_train(self)
    @current_station_index += 1
    current_station.add_train(self)
  end

  def move_back
    return if previous_station.nil?
    current_station.delete_train(self)
    @current_station_index -= 1
    current_station.add_train(self)
  end

  def previous_station
    return unless @current_station_index > 0
    @route.list_of_stations[@current_station_index - 1]
  end

  def current_station
    return @route.list_of_stations[@current_station_index]
  end

  def next_station
    return unless @current_station_index < @route.list_of_stations.size
    @route.list_of_stations[@current_station_index + 1]
  end

  # each train has its own speed
  def up_speed(arg)
    @speed += arg
  end

  # each train has its own stop-command
  def stop
    @speed = 0
  end

  def block_of_carriages
    @carriages.each do |carriage|
      yield(carriage.type, carriage.count_free_value, carriage.count_reserved_value)
    end
  end

  class << self
    def find(number)
      @@trains.detect {|train| train.number == number }
    end
    
    def all
      @@trains
    end
  end
end
