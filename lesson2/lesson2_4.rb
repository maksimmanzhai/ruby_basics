# frozen_string_literal: true

hash = {}
('a'..'z').each.with_index(1) do |letter, index|
  hash[letter] = index if 'aeiouy'.include?(letter)
end
