# frozen_string_literal: true

# class train
class Train
  attr_reader :number, :type, :carriage_count, :speed

  def initialize(number, type, carriage_count)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
  end

  def up_speed(arg)
    @speed += arg
  end

  def stop
    @speed = 0
  end

  def coupling_carriages
    @carriage_count += 1 if @speed.zero?
  end

  def uncoupling_carriages
    @carriage_count -= 1 if @speed.zero? && @carriage_count > 0
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
end
