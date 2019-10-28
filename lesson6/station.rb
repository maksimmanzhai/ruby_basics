# frozen_string_literal: true

# class station
class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  def initialize(name)
    @name = name
    if valid?
      @trains = {}
      @@stations << self
      self.register_instance
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise puts "ERROR: Name can't be empty" if @name.empty?
    raise puts "ERROR: Name should be at least 2 symbols" if @name.length < 2
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
