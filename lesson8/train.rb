# frozen_string_literal: true

# class for creating trains
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
    register_instance
  end

  def validate!
    raise "ERROR: Number of train can't be empty" if @number.empty?
    unless @number =~ /(\S{3}-\S{2}|\S{3}\s\S{2})/i
      raise 'ERROR: Number of train must be in the format XXX-XX'
    end
    raise "ERROR: Company can't be empty" if @company.empty?
    raise 'ERROR: Company should be at least 2 symbols' if @company.length < 2
  end

  def coupling_carriages(carriage)
    @carriages << carriage if carriage.type == type
  end

  def uncoupling_carriages
    @carriages.pop
  end

  def route(route)
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
    return unless @current_station_index.positive?

    @route.list_of_stations[@current_station_index - 1]
  end

  def current_station
    @route.list_of_stations[@current_station_index]
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

  def each_carriage
    @carriages.each do |carriage|
      yield(carriage) if block_given?
    end
  end

  class << self
    def find(number)
      @@trains.detect { |train| train.number == number }
    end

    def all
      @@trains
    end
  end
end
