require './carriage.rb'
require './train.rb'
require './cargoCarriage.rb'
require './cargoTrain.rb'
require './passengerCarriage.rb'
require './passengerTrain.rb'
require './route.rb'
require './station.rb'

class Main
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def create_station
    puts 'Enter name for station'
    name = gets.chomp.to_s
    @station = Station.new(name)
    @stations << @station
  end

  def create_train
    puts 'Enter number for train'
    number = gets.chomp.to_i
    @train = Train.new(number)
    @trains << @train
  end

  def create_route
    puts 'Enter name for route'
    name = gets.chomp.to_s
    puts 'Enter name for start'
    start_name = gets.chomp.to_s
    start = Station.new(start_name)
    puts 'Enter name for finish'
    finish_name = gets.chomp.to_s
    finish = Station.new(finish_name)
    route = Route.new(name, start, finish)
    @routes << route
  end

  def assign_route(train, route)
    @trains[train - 1].set_route(@routes[route - 1])
  end

  def add_cars
    
  end

  def unhook_cars
    
  end

  def move_train
    
  end

  def view_list

  end
end

main = Main.new

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
    main.create_station
  when 2
    # Create trains
    main.create_train
  when 3
    # Create routes and manage stations in it (add, delete)
    main.create_route
  when 4
    # Assign a train route
    if main.trains.empty?
      puts 'You will create train'
      main.create_train
    end
    puts 'Which train do you want to choose?'
    main.trains.each.with_index(1) do |train, index|
      puts "#{index} - #{train.number}"
    end
    puts 'Enter number for train'
    number_train = gets.chomp.to_i
    if main.routes.empty?
      puts 'You will create route'
      main.create_route
    end
    puts 'Which route do you want to choose?'
    main.routes.each.with_index(1) do |route, index|
      puts "#{index} - #{route.name}"
    end
    puts 'Enter number for route'
    number_route = gets.chomp.to_i
    main.assign_route(number_train, number_route)
  when 5
    # Add wagons to the train
    main.add_cars
  when 6
    # Unhook the cars from the train
    main.unhook_cars
  when 7
    # Move the train along the route forward and backward
    main.move_train
  when 8
    # View the list of stations and the list of trains at the station
    main.view_list
  else
    puts 'Good bye. Try again'
    break
  end
end
