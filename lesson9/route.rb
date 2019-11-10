# frozen_string_literal: true

# class for creating Routes
class Route
  include InstanceCounter
  include Validation

  validate :start, :presence
  validate :finish, :presence

  attr_reader :name, :list_of_stations, :start, :finish

  @@routes = []

  def initialize(name, start, finish)
    @name = name
    @start = start
    @finish = finish
    @list_of_stations = [start, finish]
    @@routes << self
    validate!
    register_instance
  end

  def add_station(station)
    @list_of_stations.insert(-2, station)
  end

  def delete_station(station)
    return if [start, finish].include?(station)
    @list_of_stations.delete(station)
  end

  def show_list_of_stations
    @list_of_stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end

  class << self
    def all
      @@routes
    end
  end
end
