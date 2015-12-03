#!/usr/bin/env ruby
input = File.read 'input.txt'
map = {}
santa = {x: 0, y: 0}
robosanta = {x: 0, y: 0}
deliverers = [santa, robosanta]
deliverer_index = 0

def deliver map, deliverer
  map[deliverer[:x]] ||= {}
  map[deliverer[:x]][deliverer[:y]] ||= 0
  map[deliverer[:x]][deliverer[:y]] += 1
end

deliver map, santa
deliver map, robosanta


input.each_char do |c|
  current_deliverer = deliverers[deliverer_index]
  case c
  when '^' then current_deliverer[:y] += 1
  when 'v' then current_deliverer[:y] -= 1
  when '>' then current_deliverer[:x] += 1
  when '<' then current_deliverer[:x] -= 1
  end
  deliver map, current_deliverer
  deliverer_index = (deliverer_index + 1) % deliverers.size
end

num_houses = 0
map.each_value do |column|
  num_houses += column.size
end
puts num_houses
