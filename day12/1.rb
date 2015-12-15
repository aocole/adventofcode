#!/usr/bin/env ruby

input = File.read(ARGV[0])
RE = /-?\d+/

def sum(text)
  numbers = [0]
  text.scan(RE) do |match|
    numbers << match.to_i
  end
  return numbers.reduce :+
end


raise unless sum("[1,2,3]") == 6
raise unless sum('{"a":2,"b":4}') == 6
raise unless sum('[[[3]]]') == 3
raise unless sum('{"a":{"b":4},"c":-1}') == 3
raise unless sum('{"a":[-1,1]}') == 0
raise unless sum('[-1,{"a":1}]') == 0
raise unless sum('[]') == 0
raise unless sum('{}') == 0

puts sum(input)

