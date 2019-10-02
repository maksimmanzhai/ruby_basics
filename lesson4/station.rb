# frozen_string_literal: true

# class station
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = {}
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
end
