#!/usr/bin/env ruby
REPEATED_PAIR = /(..).*\1/
PAIR_INTERRUPTED = /(.).\1/

def test(s)
  REPEATED_PAIR.match(s) && PAIR_INTERRUPTED.match(s)
end

nice = %W{qjhvhtzxzqqjkmpb xxyxx}
naughty = %W{uurcxstgmygtbstg ieodomkazucvgmuy}
nice.each do |string|
  unless test(string)
    puts "Expected #{string} to be nice"
    exit 1
  end
end
naughty.each do |string|
  if test(string)
    puts "Expected #{string} to be naughty"
    exit 1
  end
end

nice_count = 0

File.readlines('input.txt').each do |string|
  if test(string)
    puts "#{string.inspect} is nice"
    nice_count += 1
  else
    puts "#{string.inspect} is naughty"
  end

end
puts "#{nice_count} nice strings"
