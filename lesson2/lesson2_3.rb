# frozen_string_literal: true

LIMIT = 100
array = [1, 1]

loop do
  next_number = array[-1] + array[-2]
  break if next_number > LIMIT
  array << next_number
end
