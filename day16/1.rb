#!/usr/bin/env ruby

require 'set'

present_facts = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}

RE = /^Sue (\d+): (.*)$/
sue_facts = File.readlines('input.txt').collect do |line|
  line.chomp!
  match = line.match(RE)
  raise "Malformed input #{line.inspect}" unless match
  num = match[1]
  attributes = match[2].split(', ').collect{|a| a.split(': ')}
  sue = {number: num}
  attributes.each do |name, value|
    sue[name.to_sym] = value.to_i
  end
  sue
end

matching_sues = {}
present_facts.each_pair do |name, value|
  matching_sues[name] = sue_facts.select{|sue| sue[name].nil? || sue[name] == value}.collect{|sue| sue[:number]}.to_set
end

require 'pp'
pp matching_sues


the_sue = matching_sues.values.inject do |intersection, sue_set|
  pp intersection
  intersection.intersection(sue_set)

end

pp the_sue