# frozen_string_literal: true

# class station
class Station
  attr_reader :trains, :name

  @@stations = []

  def initialize(name)
    @name = name
    @trains = {}
    @@stations << self
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

  class << self
    def all
      puts @@stations
    end
  end
end
