require './route.rb'
require './station.rb'
require './train.rb'

def create_station
  puts 'Enter name for new station'
  name = gets.chomp.to_s
  Station.new(name)
end

def create_train
  puts 'Enter name for new train'
  name = gets.chomp.to_s
  Train.new(name)
end

loop do
  puts 'Enter number for your choice'
  puts '1 - Create stations'
  puts '2 - Create trains'
  puts '3 - Create routes and manage stations in it (add, delete)'
  puts '4 - Assign a Train Route'
  puts '5 - Add cars to the train'
  puts '6 - Unhook the cars from the train'
  puts '7 - Move the train along the route back and forth'
  puts '8 - View the list of stations and the list of trains at the station'
  puts 'Anything - for exit'
  choice = gets.chomp.to_i
  case choice
  when 1
    create_station
  when 2
    create_train
  when 3
    puts 'Enter name for new route'
    name = gets.chomp.to_s

    puts 'Enter start for new route'
    start = gets.chomp.to_s

    puts 'Enter finish for new route'
    finish = gets.chomp.to_s

    name = Route.new(start, finish)

    puts 'Enter number for your choice'
    puts '1 - Add station to route'
    puts '2 - Delete station from route'
    choice2 = gets.chomp.to_i
    case choice2
    when 1
      name.add_station(create_station)
    when 2
      Route.show_list_of_stations
    else
      puts 'Sorry, your choice is wrong'
    end
  when 4
    puts 'Enter name for new route'
  when 5
    p '5'
  when 6
    p '6'
  when 7
    p '7'
  when 8
    p '8'
  else
    puts 'Good bye. Try again'
    break
  end
end
