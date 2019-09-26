# frozen_string_literal: true

sides = []

puts 'Enter first side of triangle'
a = gets.chomp.to_f
sides.push(a)
puts 'Enter second side of triangle'
b = gets.chomp.to_f
sides.push(b)
puts 'Enter third side of triangle'
c = gets.chomp.to_f
sides.push(c)
sides.sort!

if sides.uniq.size == 1
  puts 'Your triangle is equilateral'
elsif sides.uniq.size == 2
  puts 'Your triangle is isosceles'
elsif sides[2]**2 == sides[0]**2 + sides[1]**2
  puts 'Your triangle is rectangular'
else
  puts 'Your triangle is wrong'
end
