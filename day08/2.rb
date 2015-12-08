#!/usr/bin/env ruby
code = []
double = []
File.readlines(ARGV[0]).each do |quoted|
  quoted.chomp!
  code << quoted.size
  double << quoted.inspect.size
end

puts "(#{double.join(' + ')}) - (#{code.join(' + ')}"
puts double.reduce(:+) - code.reduce(:+)
