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
    puts 'Enter type (cargo or passenger) for train'
    type = gets.chomp.to_s
    if type == 'cargo'
      @train = CargoTrain.new(number)
    end
    if type == 'passenger'
      @train = PassengerTrain.new(number)
    end
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
    @trains[train].set_route(@routes[route])
  end

  def add_cars(train, carriage)
    train.coupling_carriages(carriage)
  end

  def unhook_cars(train)
    train.uncoupling_carriages
  end

  def move_train(train)
    puts 'Which way do you want to move the Train (forward or back)?'
    way = gets.chomp.to_s
    if way == 'forward'
      train.move_forward
    end
    if way == 'back'
      train.move_back
    end
  end

  def view_list
    puts '===============stations==============='
    stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
    puts '===============trains==============='
    trains.each.with_index(1) do |train, index|
      puts "#{index} - #{train.number} - #{train.type} - #{train.carriages}"
    end
    puts '===============routes==============='
    routes.each.with_index(1) do |route, index|
      puts "#{index} - #{route.name}"
    end
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
    main.assign_route(number_train - 1, number_route - 1)
  when 5
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
    puts 'Enter type for Carriage'
    carriage_type = gets.chomp.to_s
    if carriage_type == 'cargo'
      puts 'Enter value for capacity'
      capacity = gets.chomp.to_i
      carriage = CargoCarriage.new(capacity)
    end
    if carriage_type == 'passenger'
      puts 'Enter value for seats'
      seats = gets.chomp.to_i
      carriage = PassengerCarriage.new(seats)
    end
    main.add_cars(main.trains[number_train - 1], carriage)
  when 6
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
    if main.trains[number_train - 1].carriages.empty?
      puts 'Your Train is empty'
      next
    end
    main.unhook_cars(main.trains[number_train - 1])
  when 7
    # Move the train along the route forward and backward
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
    main.assign_route(number_train - 1, number_route - 1)
    main.move_train(main.trains[number_train - 1])
  when 8
    # View the list of stations and the list of trains at the station
    main.view_list
  else
    puts 'Good bye. Try again'
    break
  end
end
