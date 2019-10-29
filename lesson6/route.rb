# frozen_string_literal: true

# class route
class Route
  include InstanceCounter

  attr_reader :name, :list_of_stations, :start, :finish
  
  @@routes = []

  def initialize(name, start, finish)
    @name = name
    @start = start
    @finish = finish
    validate!
    @list_of_stations = [start, finish]
    @@routes << self
    self.register_instance
  end

  def validate!
    raise "ERROR: Name of route can't be empty" if @name.empty?
    raise "ERROR: Name of route should be at least 2 symbols" if @name.length < 2
    raise "ERROR: Start station can't be empty" if @start.empty?
    raise "ERROR: Finish station can't be empty" if @finish.empty?
  rescue TypeError => e
    e.message
  rescue RuntimeError => e
    e.message
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
end
