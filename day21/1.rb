#!/usr/bin/env ruby

BOSS = {
  hp: 104,
  damage: 8,
  armor: 1
}

ME = {
  hp: 100
}

WEAPONS =[
  {name: "dagger",        cost: 8,     damage: 4,       armor: 0},
  {name: "shortsword",   cost: 10,     damage: 5,       armor: 0},
  {name: "warhammer",    cost: 25,     damage: 6,       armor: 0},
  {name: "longsword",    cost: 40,     damage: 7,       armor: 0},
  {name: "greataxe",     cost: 74,     damage: 8,       armor: 0}
]
ARMOR = [
  {name: "leather",      cost: 13,     damage: 0,       armor: 1},
  {name: "chainmail",    cost: 31,     damage: 0,       armor: 2},
  {name: "splintmail",   cost: 53,     damage: 0,       armor: 3},
  {name: "bandedmail",   cost: 75,     damage: 0,       armor: 4},
  {name: "platemail",    cost: 102,    damage: 0,       armor: 5}
]
RINGS = [
  {name: "damage +1",    cost: 25,     damage: 1,       armor: 0},
  {name: "damage +2",    cost: 50,     damage: 2,       armor: 0},
  {name: "damage +3",   cost: 100,     damage: 3,       armor: 0},
  {name: "defense +1",   cost: 20,     damage: 0,       armor: 1},
  {name: "defense +2",   cost: 40,     damage: 0,       armor: 2},
  {name: "defense +3",   cost: 80,     damage: 0,       armor: 3}
]

def generate_options
  options = []
  weapon_options = WEAPONS.combination(1).to_a
  armor_options = ARMOR.combination(0).to_a + ARMOR.combination(1).to_a
  ring_options = RINGS.combination(0).to_a + RINGS.combination(1).to_a + RINGS.combination(2).to_a
  weapon_options.each do |w|
    armor_options.each do |a|
      ring_options.each do |r|
        option = {weapons: w, armor: a, rings: r}
        option[:stats] = [w, a, r].flatten.inject({cost: 0, damage: 0, armor: 0}) do |mem, item|
          [:cost, :damage, :armor].each do |attribute|
            begin
              mem[attribute] += item[attribute]
            rescue
              require 'pry'; binding.pry
            end
          end
          mem
        end
        options << option
      end
    end
  end
  options
end

def win?(equipment, debug = false)
  stats = equipment[:stats]
  boss_net_loss = [stats[:damage] - BOSS[:armor], 1].max
  puts "boss loss: #{boss_net_loss}" if debug
  me_net_loss =  [BOSS[:damage] - stats[:armor], 1].max
  puts "me loss: #{me_net_loss}" if debug

  me = ME[:hp]
  boss = BOSS[:hp]
  turn = 0
  while me > 0 && boss > 0
    turn += 1
    puts "Turn #{turn}" if debug
    boss -= boss_net_loss
    puts "player deals #{boss_net_loss} damage, the boss goes down to #{boss} hp" if debug
    if boss <= 0
      return true
    end
    me -= me_net_loss
    puts "boss deals #{me_net_loss} damage, the player goes down to #{me} hp" if debug
  end
  return false
end

opts = generate_options
puts "#{opts.size} options"
winners = opts.select{|opt| win?(opt)}.sort{|a,b|a[:stats][:cost] <=> b[:stats][:cost] }
puts "#{winners.size} winning options. Cheapest:"
require 'pp'
pp winners.first
win?(winners.first, true)

losers = (opts - winners).sort{|a,b|b[:stats][:cost] <=> a[:stats][:cost] }
puts "#{losers.size} losing options. Priciest:"
require 'pp'
pp losers.first
win?(losers.first, true)


