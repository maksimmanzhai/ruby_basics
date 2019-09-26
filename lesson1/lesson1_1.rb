# frozen_string_literal: true

puts 'What is your name?'
name = gets.chomp
puts 'What is your height?'
height = gets.chomp.to_i
ideal_weight = height - 110
if ideal_weight >= 0
  puts "#{name}, your ideal weigth is #{ideal_weight}"
else
  puts 'Your weight is already optimal'
end
