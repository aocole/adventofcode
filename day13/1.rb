#!/usr/bin/env ruby

RE = /^(\w+) would ((gain)|(lose)) (\d+) happiness units by sitting next to (\w+)\.$/

RULES = {}
ATTENDEES = []

File.readlines(ARGV[0]).each do |line|
  line.chomp!
  match = line.match RE
  raise "Malformed input #{line.inspect}" unless match
  subject = match[1]
  object = match[6]
  points = match[5].to_i * (match[3] ? 1 : -1)
  RULES[subject] ||= {}
  RULES[subject][object] = points
  ATTENDEES << subject
  ATTENDEES << object
end
ATTENDEES.uniq!

require 'pp'
pp RULES
pp ATTENDEES

def arrangement_happiness(arrangement)
  happiness = 0
  arrangement << arrangement[0] # make the list wrap around the table
  arrangement.each_cons(2) do |a, b|
    happiness += RULES[a][b]
    happiness += RULES[b][a]
  end
  return happiness
end

happinesses = []
ATTENDEES.permutation do |arrangement|
  happinesses << [arrangement_happiness(arrangement), arrangement]
end

happinesses.sort!{|a,b| b[0] <=> a[0]}
optimal = happinesses[0]
puts "Arrangement #{optimal[1][0..-1].join(', ')} is optimal: #{optimal[0]} happinesses"
