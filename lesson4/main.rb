require './route.rb'
require './station.rb'
require './train.rb'

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
  choice = gets.chomp.to_i
  case choice
  when 1
    puts 'Enter name for new station'
    name = gets.chomp.to_s
    Station.new(name)
  when 2
    puts 'Enter name for new train'
    name = gets.chomp.to_s
    Train.new(name)
  when 3
    puts 'Enter name for new route'
    name = gets.chomp.to_s
    Route.new(name)
  when 4
    p '4'
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
