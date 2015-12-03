#!/usr/bin/env ruby
input = File.read 'input.txt'
map = {}
x = 0
y = 0

def deliver map, x, y
  map[x] ||= {}
  map[x][y] ||= 0
  map[x][y] += 1
end

deliver map, x, y

input.each_char do |c|
  case c
  when '^' then y += 1
  when 'v' then y -= 1
  when '>' then x += 1
  when '<' then x -= 1
  end
  deliver map, x, y
end

num_houses = 0
map.each_value do |column|
  num_houses += column.size
end
puts num_houses
