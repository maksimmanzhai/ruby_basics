# frozen_string_literal: true

# class for creating stations
class Station
  include InstanceCounter

  attr_reader :trains, :name, :stations

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
    self.register_instance
  end

  def validate!
    raise 'Name of station can\'t be empty' if @name.empty?
    raise 'Name of station should be at least 2 symbols' if @name.length < 2
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    trains.select { |number, train| train.type == type }.size
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
