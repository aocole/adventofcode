#!/usr/bin/env ruby
code = []
strings = []
File.readlines(ARGV[0]).each do |quoted|
  quoted.chomp!
  code << quoted.size
  strings << eval(quoted).size
end

puts "(#{code.join(' + ')} - (#{strings.join(' + ')})"
puts code.reduce(:+) - strings.reduce(:+)
