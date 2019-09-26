# frozen_string_literal: true

def quadratic(a, b, c)
  d = b**2 - 4 * a * c
  if d.positive?
    d_sqrt = Math.sqrt(d)
    x1 = (- b + d_sqrt) / (2 * a)
    x2 = (- b - d_sqrt) / (2 * a)
    puts "d = #{d}, x1 = #{x1}, x2 = #{x2}"
  elsif d.zero?
    x1 = - (b / (2 * a))
    puts "d = #{d}, x1 = #{x1}"
  else
    puts 'No roots'
  end
end

puts 'Enter first index'
x = gets.chomp.to_f
puts 'Enter second index'
y = gets.chomp.to_f
puts 'Enter third index'
z = gets.chomp.to_f

quadratic(x, y, z)
