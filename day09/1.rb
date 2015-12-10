#!/usr/bin/env ruby

input = File.readlines(ARGV[0]).collect{|l|l.chomp}
all_cities = []
arr = input.collect do |l|
  cities, distance = l.split ' = '
  l, r = cities.split ' to '
  all_cities << l
  all_cities << r
  [distance.to_i, l, r]
end

arr.sort!{|a,b| a[0] <=> b[0]}
all_cities.uniq!

at = arr.first[1]
visited = []
distance = 0

puts "Starting at #{at}"

while visited.size < all_cities.size
  candidates = arr.select{|distance, origin, destination| origin == at}
  candidates.sort!{|a,b| a[0] <=> b[0]}
  trip = candidates.first
  at = trip.last
  visited << at
  distance += trip.first
end

puts visited.join ' -> '
puts "Distance: #{distance}"
