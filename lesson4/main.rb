require './route.rb'
require './station.rb'
require './train.rb'

stations = []
trains = []
routes = []

loop do
  puts 'Enter number for your choice'
  puts '1 - Create station'
  puts '2 - Create train'
  puts '3 - Create routes and manage stations in it (add, delete)'
  puts '4 - Assign a train route'
  puts '5 - Add cars to the train'
  puts '6 - Unhook the cars from the train'
  puts '7 - Move the train along the route back and forth'
  puts '8 - View the list of stations and the list of trains at the station'
  puts 'Anything - for exit'
  choice = gets.chomp.to_i
  case choice
  when 1
    puts 'Enter name for new station'
    name_station = gets.chomp.to_s
    stations << Station.new(name_station)
  when 2
    puts 'Enter number for new train'
    number_train = gets.chomp.to_i
    puts 'Enter type for new train'
    type_train = gets.chomp.to_s
    puts 'Enter carriage count for new train'
    carriage_count_train = gets.chomp.to_s
    trains << Train.new(number_train, type_train, carriage_count_train)
  when 3
    puts 'Enter name for new route'
    name_route = gets.chomp.to_s
    puts 'Enter start for new route'
    start = gets.chomp.to_s
    Station.new(start)
    puts 'Enter finish for new route'
    finish = gets.chomp.to_s
    Station.new(finish)
    p Route.new(name_route, start, finish)
    puts 'Enter number for your choice'
    puts '1 - Add station to route'
    puts '2 - Delete station from route'
    choice2 = gets.chomp.to_i
    case choice2
    when 1
      p '3-1'
    when 2
      p '3-2'
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
    puts 'Good bye.'
    break
  end
end
