#!/usr/bin/env ruby

input = File.readlines ARGV[0]
REGISTER = {'a' => 1, 'b' => 0}
RE = /(\w+) (([+-]\d+)|(\w+))(, ([+-]\d+))?/

instructions = input.collect{|l| l.chomp}


pc = 0

while (ins = instructions[pc]) != nil
  match = RE.match(ins)
  puts "PC: #{pc}; ins: #{ins}; REGISTER: #{REGISTER.inspect}"
  case match[1]
  when 'hlf'
    REGISTER[match[2]] /= 2
    pc += 1
  when 'tpl'
    REGISTER[match[2]] *= 3
    pc += 1
  when 'inc'
    REGISTER[match[2]] += 1
    pc += 1
  when 'jmp'
    pc += match[2].to_i
  when 'jie'
    if REGISTER[match[2]].even?
      pc += match[6].to_i
    else
      pc += 1
    end
  when 'jio'
    if REGISTER[match[2]] == 1
      pc += match[6].to_i
    else
      pc += 1
    end
  else
    raise "Unknown instruction #{match[1].inspect} in line #{ins.inspect}"
  end
end
puts "A: #{REGISTER['a']}, B: #{REGISTER['b']}"
