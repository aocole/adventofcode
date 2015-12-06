#!/usr/bin/env ruby
threevowels = /(.*?[aeiou].*?){3,}/
repeated = /(.)\1/
evil = /(ab)|(cd)|(pq)|(xy)/

nice_count = 0

File.readlines('input.txt').each do |string|
  if threevowels.match(string) &&
     repeated.match(string) &&
     !evil.match(string)
    puts "#{string.inspect} is nice"
    nice_count += 1
  else
    puts "#{string.inspect} is naughty"
  end

end
puts "#{nice_count} nice strings"