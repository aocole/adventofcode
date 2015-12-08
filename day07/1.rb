#!/usr/bin/env ruby

input = File.read ARGV[0]
while(true) do
  puts input
  simple = input.match /^(\d+) -> ([a-z]+)\n/
  unary = input.match /^NOT (\d+) -> ([a-z]+)\n/
  binary = input.match /^(\d+) ([A-Z]+) (\d+) -> ([a-z]+)\n/
  if simple
    change = input.gsub! /\b#{simple[2]}\b(?=.*->)/, simple[1]
    if !change
      input.gsub! simple[0], "#{simple[2]}: #{simple[1]}\n"
    end
  elsif unary
    output = (~unary[1].to_i)%65536
    change = input.gsub! /\b#{unary[2]}\b(?=.*->)/, "#{output}"
    if !change
      input.gsub! unary[0], "#{unary[2]}: #{output}\n"
    end
  elsif binary
    op1 = binary[1].to_i
    op2 = binary[3].to_i
    output = case binary[2]
    when 'AND' then op1 & op2
    when 'OR' then op1 | op2
    when 'LSHIFT' then op1 << op2
    when 'RSHIFT' then op1 >> op2
    else
      raise "wtf is #{binary[2].inspect}?"
    end % 65536
    change = input.gsub! /\b#{binary[4]}\b(?=.*->)/, "#{output}"
    if !change
      input.gsub! binary[0], "#{binary[4]}: #{output}\n"
    end
  else
    break
  end
  puts "="*80
end

