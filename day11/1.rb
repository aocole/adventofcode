#!/usr/bin/env ruby

input = ARGV[0]

alphabet = 'abcdefghijklmnopqrstuvwxyz'.split('')
BANNED = /[ilo]/
STRAIGHTS = Regexp.compile(alphabet.each_cons(3).collect{|triple| "(#{triple.join})"}.join('|'))
DOUBLE_REPEAT = /(\w)\1.*(\w)\2/

def good_password? pass
  return false if pass =~ BANNED
  return false unless pass =~ STRAIGHTS
  match = pass.match(DOUBLE_REPEAT)
  return false unless match
  return match[1] != match[2]
end

pass = input.next
while !good_password?(pass)
  pass = pass.next
end

puts pass
