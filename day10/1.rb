#!/usr/bin/env ruby

input = "1113222113"
repeats = /^(\d)\1+/
singles = /^(\d)/

50.times do
  output = ''
  arr = input.split ''
  arr << 'x' # dummy char
  current_char = arr.shift
  current_count = 1
  arr.each do |c|
    if c == current_char
      current_count += 1
    else
      output << current_count.to_s
      output << current_char
      current_char = c
      current_count = 1
    end
  end
  input = output
end
puts input.size

