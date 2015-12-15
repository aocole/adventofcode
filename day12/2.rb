#!/usr/bin/env ruby

require 'json'
input = JSON.load File.read(ARGV[0])
RED = 'red'

def sum(obj)
  numbers = [0]
  case obj
  when Numeric
    numbers << obj
  when Array
    numbers = obj.collect{|el| sum(el)}
  when Hash
    red = obj.values.detect{|el| el == RED}
    if red
      numbers = [0]
    else
      numbers = obj.values.collect{|el| sum(el)}
    end
  end
  return numbers.reduce :+
end

def check(text, expected)
  j = JSON.load(text)
  raise unless sum(j) == expected
end

check("[1,2,3]", 6)
check('[1,{"c":"red","b":2},3]', 4)
check('{"d":"red","e":[1,2,3,4],"f":5}', 0)
check('[1,"red",5]', 6)



puts sum(input)

