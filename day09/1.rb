#!/usr/bin/env ruby

input = File.readlines(ARGV[0]).collect{|line|line.chomp}
all_cities = []
arr = input.collect do |line|
  cities, distance = line.split ' = '
  l, r = cities.split ' to '
  all_cities << l
  all_cities << r
  [distance.to_i, l, r]
end
inverses = arr.collect do |line|
  [line[0], line[2], line[1]]
end
arr += inverses

all_cities.uniq!

trips = []
all_cities.permutation do |itin|
  prev_city = nil
  distance = itin.inject(0) do |sum, next_city|
    retval = 0
    if !prev_city.nil?
      leg = arr.detect{|way| way[1]==prev_city && way[2]==next_city}
      retval = sum + leg[0]
    end
    prev_city = next_city
    retval
  end
  trips << ([distance] + itin)
end

trips.sort!{|a,b| a[0] <=> b[0]}

trips.each do |t|
  puts "Distance: #{t[0]}, #{t[1..-1].join ' -> '}"
end