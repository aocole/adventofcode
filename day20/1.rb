#!/usr/bin/env ruby

target = ARGV[0].to_i
houses = Array.new(target/10, 0)
(1..(target/10)).each do |elf_num|
  (elf_num..(target/10)).step(elf_num) do |house_num|
    houses[house_num-1] += elf_num * 10
  end
end

houses.each_with_index do |val, i|
  if val >= target
    puts "House #{i+1} got #{val} presents"
    break
  end
end