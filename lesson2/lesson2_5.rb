# frozen_string_literal: true

def leap?(year)
  (year % 4 != 0) || (year % 100 == 0) && (year % 400 != 0)
end

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

date = []
puts 'Enter your year'
year = gets.to_i
days[1] += 1 if leap?(year)

puts 'Enter your month (1-12)'
month = gets.to_i
abort("Invalid month") unless month.between?(1, 12)

month_days = days[month - 1]
puts "Enter your day (1-#{month_days})"
day = gets.to_i
abort("Invalid day") unless day.between?(1, month_days)

days_count = days.take(month - 1).sum + day
