#!/usr/bin/env ruby

CONTAINERS = [43, 3, 4, 10, 21, 44, 4, 6, 47, 41, 34, 17, 17, 44, 36, 31, 46, 9, 27, 38]
TEST_CONTAINERS = [20, 15, 10, 5, 5]


def search containers, target
  fitting_combinations = []
  containers.length.times do |i|
    containers.combination(i+1).each do |combination|
      if combination.reduce(:+) == target
        fitting_combinations << combination
      end
    end
  end
  return fitting_combinations
end

require 'pp'

puts "Test containers:"
pp search(TEST_CONTAINERS, 25)

winners = search(CONTAINERS, 150)
pp winners
puts "#{winners.size} combinations fit 150 liters."

winners.sort!{|a,b| a.size <=> b.size}
min_count = winners.first.size
min_combinations = winners.select{|a| a.size == min_count}
puts "#{min_combinations.size} combinations fit 150 liters with just #{min_count} containers."
