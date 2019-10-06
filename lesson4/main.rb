require './carriage.rb'
require './train.rb'
require './cargoCarriage.rb'
require './cargoTrain.rb'
require './passengerCarriage.rb'
require './passengerTrain.rb'
require './route.rb'
require './station.rb'


class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def create_station
    
  end

  def create_train
    
  end

  def create_route
    
  end

  def method_name
    
  end

  def method_name
    
  end

  def method_name
    
  end

  def method_name
    
  end

  def method_name
    
  end
end

menu = Main.new

loop do
  puts 'Enter number for your choice'
  puts '1 - Create Station'
  puts '2 - Create Train'
  puts '3 - Create Route and manage Stations in it (add, delete)'
  puts '4 - Assign a Train Route'
  puts '5 - Add Cars to the Train'
  puts '6 - Unhook the Cars from the Train'
  puts '7 - Move the Train along the Route back and forth'
  puts '8 - View the list of Stations and the list of Trains at the Station'
  puts 'Anything - for exit'
  choice = gets.chomp.to_i
  case choice
  when 1
    # Create stations
  when 2
    # Create trains
  when 3
    # Create routes and manage stations in it (add, delete)
  when 4
    # Assign a train route
  when 5
    # Add wagons to the train
  when 6
    # Unhook the cars from the train
  when 7
    # Move the train along the route forward and backward
  when 8
    # View the list of stations and the list of trains at the station
  else
    puts 'Good bye. Try again'
    break
  end
end
