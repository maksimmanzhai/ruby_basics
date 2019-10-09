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
    @stations << start
    puts 'Enter name for finish'
    finish_name = gets.chomp.to_s
    finish = Station.new(finish_name)
    @stations << finish
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
    main.create_station
  when 2
    main.create_train
  when 3
    puts 'Enter number for your choice'
    puts '1 - Create Route'
    puts '2 - Add Station to Route'
    puts '3 - Delete Station from Route'
    puts 'Anything - for back to previous menu'
    choice2 = gets.chomp.to_i
    case choice2
    when 1
      main.create_route
    when 2
      if main.routes.empty?
        puts 'First you need to create a Route'
        main.create_route
      end
      puts 'Which route do you want to choose?'
      main.routes.each.with_index(1) do |route, index|
        puts "#{index} - #{route.name}"
      end
      puts 'Enter number for Route'
      number_route = gets.chomp.to_i
      puts 'Enter number for add Station'
      puts '1 - Add new Station'
      puts '2 - Add existing Station'
      puts 'Anything - for back to previous menu'
      number_station = gets.chomp.to_i
      case number_station
      when 1
        main.create_station
        number_station = (main.stations).size - 1
      when 2
        puts 'Enter number for add existing Station'
        main.stations.each.with_index(1) do |station, index|
          puts "#{index} - #{station.name}"
        end
        number_station = gets.chomp.to_i
      else
        next
      end
      main.routes[number_route - 1].add_station(main.stations[number_station - 1])
    when 3
      if main.routes.empty?
        puts 'First you need to create a Route'
        main.create_route
      end
      puts 'Which route do you want to choose?'
      main.routes.each.with_index(1) do |route, index|
        puts "#{index} - #{route.name}"
      end
      puts 'Enter number for route'
      number_route2 = gets.chomp.to_i
      puts 'Enter number for delete Station from Route'
      p main.routes[number_route2 - 1].show_list_of_stations
      number_station2 = gets.chomp.to_i
      (main.routes[number_route2 - 1]).delete_station(main.stations[number_station2 - 1])
    else
      next
    end
  when 4
    # Assign a train route
    if main.trains.empty?
      puts 'You will create Train'
      main.create_train
    end
    puts 'Which Train do you want to choose?'
    main.trains.each.with_index(1) do |train, index|
      puts "#{index} - #{train.number}"
    end
    puts 'Enter number for Train'
    number_train = gets.chomp.to_i
    if main.routes.empty?
      puts 'First you need to create a Route'
      main.create_route
    end
    puts 'Which Route do you want to choose?'
    main.routes.each.with_index(1) do |route, index|
      puts "#{index} - #{route.name}"
    end
    puts 'Enter number for Route'
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
