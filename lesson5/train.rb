# frozen_string_literal: true

# class train
class Train
  include Company

  @@trains = []

  attr_reader :number, :type, :speed, :carriages

  def initialize(number, company)
    @number = number
    @speed = 0
    @carriages = []
    @company = company
    @@trains << self
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

  class << self
    def find(number)
      @@trains.detect {|train| train.number == number }
    end
  end
end
