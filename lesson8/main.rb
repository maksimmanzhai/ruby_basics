require './company.rb'
require './instance_counter.rb'
require './carriage.rb'
require './train.rb'
require './cargo_carriage.rb'
require './cargo_train.rb'
require './passenger_carriage.rb'
require './passenger_train.rb'
require './route.rb'
require './station.rb'
require './test.rb'

class Main
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = Station.all
    @trains = Train.all
    @routes = Route.all
  end

  def run
    loop do
      puts "Stations: #{Station.instances}"
      puts "Cargo Trains: #{CargoTrain.instances}"
      puts "Passenger Trains: #{PassengerTrain.instances}"
      puts "Routes: #{Route.instances}"
      puts 'Enter number for your choice'
      puts '1 - Create Station'
      puts '2 - Create Train'
      puts '3 - Create Route'
      puts '4 - Add Station to Route'
      puts '5 - Delete Station from Route'
      puts '6 - Assign a Train Route'
      puts '7 - Add Cariages to the Train'
      puts '8 - Unhook the Cariages from the Train'
      puts '9 - Move the Train along the Route back and forth'
      puts '10 - View the list of Stations and the list of Trains at the Station'
      puts '11 - Find Train by number of Train'
      puts '12 - Reserve a seat or capacity in the Carriage'
      puts '13 - View list of Trains on Station'
      puts '14 - View list of Carriage on Trains'
      puts 'Anything - for exit'
      choice = gets.chomp.to_i
      case choice
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        add_station_to_route
      when 5
        delete_station_from_route
      when 6
        assign_route
      when 7
        add_cars
      when 8
        unhook_cars
      when 9
        move_train
      when 10
        view_list_station
      when 11
        find_train
      when 12
        reserve
      when 13
        view_list_trains_on_station
      when 14
        view_list_carriage_on_train
      else
        puts 'Good bye. Try again'
        break
      end
    end
  end

  def create_station
    puts 'Enter name for Station'
    name = gets.chomp
    station = Station.new(name)
    stations << station
    station
  rescue => e
    puts e.message
    retry
  end

  def create_train
    puts 'Enter number for Train in format XXX-XX'
    number = gets.chomp.to_s
    puts 'Enter Company for Train'
    company = gets.chomp.to_s
    puts 'Enter number of type for Train'
    puts '1 - Cargo'
    puts '2 - Passenger'
    type = gets.chomp.to_i
    case type
    when 1
      train = CargoTrain.new(number, company)
    when 2
      train = PassengerTrain.new(number, company)
    else
      return nil
    end
    @trains << train
    train.print_company
    train
  rescue => e
    puts e.message
    retry
  end

  def create_route
    puts 'Enter name for route'
    name = gets.chomp.to_s
    puts 'Choose Station for start of Route'
    start = choose_station
    puts 'Choose Station for finish of Route'
    finish = choose_station
    route = Route.new(name, start, finish)
    @routes << route
    route
  rescue => e
    puts e.message
    retry
  end

  def add_station_to_route
    if routes.empty?
      puts 'First you need to create a Route'
      create_route
    end
    route = choose_route
    station = choose_station
    route.add_station(station)
  end

  def delete_station_from_route
    if routes.empty?
      return puts 'You will not delete a station because there are no routes'
    end
    route = choose_route
    station = choose_station_from_route(route)
    route.delete_station(station)
  end

  def assign_route
    if trains.empty?
      puts 'You will create Train'
      create_train
    end
    number_train = choose_train
    puts "number_train: #{number_train}"
    if routes.empty?
      puts 'First you need to create a Route'
      create_route
    end
    number_route = choose_route
    number_train.set_route(number_route)
  end

  def add_cars
    if trains.empty?
      puts 'You will create Train'
      create_train
    end
    number_train = choose_train
    puts 'Enter type for Carriage'
    puts '1 - Cargo'
    puts '2 - Passenger'
    carriage_type = gets.chomp.to_i
    puts 'Enter company for Carriage'
    company = gets.chomp.to_s
    if carriage_type == 1
      puts 'Enter value for capacity'
      capacity = gets.chomp.to_i
      carriage = CargoCarriage.new(capacity, company)
    end
    if carriage_type == 2
      puts 'Enter value for seats'
      seats = gets.chomp.to_i
      carriage = PassengerCarriage.new(seats, company)
    end
    number_train.coupling_carriages(carriage)
  end

  def unhook_cars
    if trains.empty?
      return puts 'You cannot unhook a Carriage because you do not have Trains'
    end
    train = choose_train
    if train.carriages.empty?
      return puts 'You cannot unhook a Carriage, because the selected Train has no Carriages'
    end
    train.uncoupling_carriages
  end

  def move_train
    if trains.empty?
      puts 'You will create Train'
      create_train
    end
    train = choose_train
    puts 'Which way do you want to move the Train (forward or back)?'
    way = gets.chomp.to_s
    if way == 'forward'
      train.move_forward
    end
    if way == 'back'
      train.move_back
    end
  end

  def view_list_station
    puts '============stations============'
    stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name} - #{station.trains}"
    end
  end

  def find_train
    puts 'Enter the Train number to search'
    number_train = gets.chomp.to_i
    Train.find(number_train)
  end

  def choose_station
    puts 'Enter the number for action on the Station'
    puts '1 - Add or choose new Station'
    puts '2 - Choose existing Station'
    puts 'Anything - for back to previous menu'
    number_station = gets.chomp.to_i
    case number_station
    when 1
      create_station
    when 2
      if stations.empty?
        puts 'You will create Station'
        create_station
      end
      puts 'Enter number for existing Station'
      stations.each.with_index(1) do |station, index|
        puts "#{index} - #{station.name}"
      end
      number_station = gets.chomp.to_i - 1
      stations[number_station]
    else
      puts 'Please, enter 1 or 2'
    end
  end

  def reserve
    if trains.empty?
      puts 'You will create Train'
      create_train
    end
    train = choose_train
    if train.carriages.empty?
      puts 'You will hook Carriage'
      add_cars
    end
    carriage = choose_carriage(train)
    if carriage.type == 'cargo'
      puts 'Enter the amount of space required'
      value = gets.chomp.to_i
      carriage.reserve_capacity(value)
    end
    if carriage.type == 'passenger'
      carriage.reserve_seats
    end
  rescue => e
    puts e.message
    retry
  end

  def choose_carriage(train)
    begin
      puts 'Enter number of Carriage from Train'
      number = gets.chomp.to_i
      raise 'Carriage with this number does not exist' if !(train.carriages[number - 1])
    rescue => e
      puts e.message
      retry
    end
    train.carriages[number - 1]
  end

  def view_list_trains_on_station
    station = choose_station
    puts "\tNumber\tType\tCarriages count"
    station.each_train{ |train| puts "\t#{train.number}\t#{train.type}\t#{train.carriages.count}" }
  end

  def view_list_carriage_on_train
    train = choose_train
    puts "\tType\tFree\tReserved"
    train.each_carriage{ |carriage| puts "\t#{carriage.type}\t#{carriage.free}\t#{carriage.reserved}" }
  end

  def choose_station_from_route(route)
    route.show_list_of_stations
    puts 'Enter number for Station'
    number_station = gets.chomp.to_i - 1
    route.delete_station(number_station)
  end

  def choose_train
    puts 'Which Train do you want to choose?'
    trains.each.with_index(1) do |train, index|
      puts "#{index} - #{train.number}"
    end
    puts 'Enter number for Train'
    puts 'Enter 0 for return to main menu'
    number_train = gets.chomp.to_i - 1
    run if number_train == -1
    trains[number_train]
  end

  def choose_route
    puts 'Which route do you want to choose?'
    routes.each.with_index(1) do |route, index|
      puts "#{index} - #{route.name}"
    end
    puts 'Enter number for Route'
    number_route = gets.chomp.to_i - 1
    routes[number_route]
  end
end

main = Main.new
main.run
