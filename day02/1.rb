#!/usr/bin/env ruby

input = File.readlines 'input'
dimensions = input.collect {|string| string.split('x').collect{|n|n.to_i}.sort}
areas = dimensions.collect do |dims|
  slack = dims[0]*dims[1]
  surface = 2 * (slack + dims[1]*dims[2] + dims[0]*dims[2])
  slack + surface
end
total = areas.reduce :+
puts total
