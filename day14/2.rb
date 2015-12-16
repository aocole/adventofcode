#!/usr/bin/env ruby

RE = /(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds\./

CARIBOU = []
TIME = ARGV[1].to_i
File.readlines(ARGV[0]).each do |line|
  match = line.match RE
  raise "Malformed input #{line.inspect}" unless match
  CARIBOU << {
    name: match[1],
    speed: match[2].to_i,
    duration: match[3].to_i,
    rest: match[4].to_i,
    points: 0
  }
end

def caribou_distance_at_time(caribou, time)
  period = caribou[:duration] + caribou[:rest]
  periods = time / period
  remainder = time % period
  active_remainder = [caribou[:duration], remainder].min

  distance = (periods * caribou[:duration] + active_remainder) * caribou[:speed]

  return distance
end


TIME.times do |i|
  second = i+1
  pack = CARIBOU.collect{|c| [c, caribou_distance_at_time(c, second)]}.sort{|a,b| b[1] <=> a[1]}
  leader = pack[0]
  pack.each do |c, distance|
    if distance == leader[1]
      c[:points] += 1
    end
  end
end

require 'pp'
pp CARIBOU.sort{|a,b| b[:points] <=> a[:points]}
