# frozen_string_literal: true

# class station
class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  def initialize(name)
    @name = name
    @trains = {}
    @@stations << self
    validate!
    self.register_instance
  end

  def validate!
    raise "ERROR: Name of station can't be empty" if @name.empty?
    raise "ERROR: Name of station should be at least 2 symbols" if @name.length < 2
  end

  def add_train(train)
    @trains[train.number] = train
  end

  def trains_by_type(type)
    trains.select { |number, train| train.type == type }.size
  end

  def delete_train(train)
    @trains.delete(train.number)
  end

  def block_of_trains
    @trains.each do |number, train|
      yield(train.number, train.type, train.carriages)
    end
  end

  class << self
    def all
      puts @@stations
    end
  end
end
