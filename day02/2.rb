#!/usr/bin/env ruby

input = File.readlines 'input'
dimensions = input.collect {|string| string.split('x').collect{|n|n.to_i}.sort}
ribbons = dimensions.collect do |dims|
  wrap = 2 * (dims[0] + dims[1])
  bow = dims.reduce 1, :*
  wrap + bow
end
total = ribbons.reduce :+
puts total
