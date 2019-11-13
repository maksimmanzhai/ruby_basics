# frozen_string_literal: true

# class for creating Stations
class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name, :stations

  validate :name, :presence

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    trains.select { |_number, train| train.type == type }.size
  end

  def delete_train(train)
    @trains.delete(train.number)
  end

  def each_train
    @trains.each do |train|
      yield(train) if block_given?
    end
  end

  class << self
    def all
      @@stations
    end
  end
end
