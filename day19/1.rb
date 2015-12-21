#!/usr/bin/env ruby
require 'pp'

SUBSTITUTIONS = {}
RE = /(\w+) => (\w+)/
File.readlines(ARGV[0]).each do |line|
  line.chomp!
  match = line.match RE
  if match
    SUBSTITUTIONS[match[1]] ||= []
    SUBSTITUTIONS[match[1]] << match[2]
  else
    next if line.empty?
    INPUT = line
  end
end

puts "Substituting in #{INPUT}"
pp SUBSTITUTIONS

molecules = []
inverted_subs = {}
SUBSTITUTIONS.each do |key, substitution_set|
  substitution_set.each do |substitution|
    inverted_subs[substitution] = key
    last_offset = 0
    while m = INPUT.match(/#{key}/, last_offset)
      output = INPUT.dup
      # require 'pry'; binding.pry
      output[m.begin(0)..(m.end(0)-1)] = substitution
      molecules << output
      last_offset = m.end(0)
    end
  end
end

pp molecules
puts "#{molecules.uniq.size} unique molecules"



work_string = INPUT.dup
sorted_products = inverted_subs.keys.sort{|a,b|b.size <=> a.size}

steps = 0
while work_string != 'e' 
  sorted_products.each do |product|
    if work_string.sub!(product, inverted_subs[product])
      steps +=1
      puts "#{steps}: #{work_string}"
      break
    end
  end
end