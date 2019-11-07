# frozen_string_literal: true

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

# class for creating Main menu
class Main
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = Station.all
    @trains = Train.all
    @routes = Route.all
  end

  # rubocop: disable Metrics/MethodLength
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
      puts '10 - View list of Stations and list of Trains at the Station'
      puts '11 - Find Train by number of Train'
      puts '12 - Reserve a seat or capacity in the Carriage'
      puts '13 - View list of Trains on Station'
      puts '14 - View list of Carriage on Trains'
      puts 'Anything - for exit'
      choice = gets.chomp.to_i
      case choice
      when 1 then  create_station
      when 2 then  create_train
      when 3 then  create_route
      when 4 then  add_station_to_route
      when 5 then  delete_station_from_route
      when 6 then  assign_route
      when 7 then  add_cars
      when 8 then  unhook_cars
      when 9 then  move_train
      when 10 then  view_list_station
      when 11 then  find_train
      when 12 then  reserve
      when 13 then  view_list_trains_on_station
      when 14 then  view_list_carriage_on_train
      else
        puts 'Good bye. Try again'
        break
      end
    end
  end
  # rubocop: enable Metrics/MethodLength

  def create_station
    puts 'You will create Station. Enter name for Station'
    name = gets.chomp
    station = Station.new(name)
    stations << station
    station
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_train
    puts 'You will create Train'
    puts 'Enter number for Train in format XXX-XX'
    number = gets.chomp.to_s
    puts 'Enter Company for Train'
    company = gets.chomp.to_s
    puts 'Enter number of type for Train (1 - Cargo, 2 - Passenger)'
    type = gets.chomp.to_i
    train = create_cargo_train(number, company) if type == 1
    train = create_passenger_train(number, company) if type == 2
    @trains << train
    train.print_company
    train
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_cargo_train
    CargoTrain.new(number, company)
  end

  def create_passenger_train
    PassengerTrain.new(number, company)
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
  rescue StandardError => e
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
    raise puts 'You will not delete a station from this routes' if routes.empty?

    route = choose_route
    station = choose_station_from_route(route)
    route.delete_station(station)
  rescue StandardError => e
    puts e.message
    retry
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
    number_train.route(number_route)
  end

  def add_cars
    number_train = choose_train
    puts 'Enter type for Carriage (1 - Cargo, 2 - Passenger)'
    carriage_type = gets.chomp.to_i
    puts 'Enter company for Carriage'
    company = gets.chomp.to_s
    carriage = create_cargo_carriage(company) if carriage_type == 1
    carriage = create_passenger_carriage(company) if carriage_type == 2
    number_train.coupling_carriages(carriage)
  end

  def create_cargo_carriage(company)
    puts 'Enter value for capacity'
    capacity = gets.chomp.to_i
    CargoCarriage.new(capacity, company)
  end

  def create_passenger_carriage(company)
    puts 'Enter value for seats'
    seats = gets.chomp.to_i
    PassengerCarriage.new(seats, company)
  end

  def unhook_cars
    raise 'You not have Trains' if trains.empty?

    train = choose_train
    raise 'There are no Carriages on your Train' if train.carriages.empty?

    train.uncoupling_carriages
  rescue StandardError => e
    puts e.message
    retry
  end

  def move_train
    if trains.empty?
      puts 'You will create Train'
      create_train
    end
    train = choose_train
    puts 'Which way do you want to move the Train (forward or back)?'
    way = gets.chomp.to_s
    train.move_forward if way == 'forward'
    train.move_back if way == 'back'
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
    puts "Enter number: \n1. Add Station \n2. Choose Station \n0. Back to menu"
    number_station = gets.chomp.to_i
    case number_station
    when 1
      create_station
    when 2
      create_station if stations.empty?
      puts 'Enter number for existing Station'
      stations.each.with_index(1) do |station, index|
        puts "#{index} - #{station.name}"
      end
      stations[gets.chomp.to_i - 1]
    else
      puts 'Please, enter 1 or 2'
    end
  end

  def reserve
    create_train if trains.empty?
    train = choose_train
    add_cars if train.carriages.empty?
    carriage = choose_carriage(train)
    if carriage.type == 'cargo'
      puts 'Enter the amount of space required'
      value = gets.chomp.to_i
      carriage.reserve_capacity(value)
    end
    carriage.reserve_seats if carriage.type == 'passenger'
  rescue StandardError => e
    puts e.message
    retry
  end

  def choose_carriage(train)
    begin
      puts 'Enter number of Carriage from Train'
      number = gets.chomp.to_i
      raise 'This Carriage does not exist' unless train.carriages[number - 1]
    rescue StandardError => e
      puts e.message
      retry
    end
    train.carriages[number - 1]
  end

  def view_list_trains_on_station
    station = choose_station
    puts "\tNumber\tType\tCarriages count"
    station.each_train do |train|
      puts "\t#{train.number}\t#{train.type}\t#{train.carriages.count}"
    end
  end

  def view_list_carriage_on_train
    train = choose_train
    puts "\tType\tFree\tReserved"
    train.each_carriage do |carriage|
      puts "\t#{carriage.type}\t#{carriage.free}\t#{carriage.reserved}"
    end
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
    puts 'Enter number for Train (0 - for return to main menu)'
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
