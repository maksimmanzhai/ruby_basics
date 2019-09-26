# frozen_string_literal: true

puts 'Enter size of base'
a = gets.chomp.to_f
puts 'Enter size of height'
height = gets.chomp.to_f
area_of_triangle = (1.0 / 2.0) * a * height
puts "Area of a triangle is #{area_of_triangle}"
