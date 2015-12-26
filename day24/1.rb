#!/usr/bin/env ruby
require 'pp'
input = [1,3,5,11,13,17,19,23,29,31,41,43,47,53,59,61,67,71,
         73,79,83,89,97,101,103,107,109,113]
total_weight = input.reduce(:+)
target_weight = total_weight/3
puts "Total weight: #{total_weight}, target: #{target_weight}"
if total_weight % 3 != 0
  raise "How are we supposed to do this?"
end

groups = []
(1..input.length).each do |i|
  input.combination(i).each do |first_group|
    if first_group.reduce(:+) == target_weight
      works = false
      remainder = input - first_group
      (1..remainder.length).each do |j|
        remainder.combination(j).each do |second_group|
          if second_group.reduce(:+) == target_weight
            third_group = remainder - second_group
            grouping = [first_group, second_group, third_group]
            pp grouping
            groups << grouping
            works = true
            break
          end
        end
        break if works
      end
    end
  end

  break if !groups.empty?

end


sorted = groups.sort_by{|a| a[0].reduce(:*)}
puts "Winner QE: #{sorted[0][0].reduce(:*)}"
pp sorted[0]

