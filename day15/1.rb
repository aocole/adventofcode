#!/usr/bin/env ruby

INGREDIENTS = [
  {name: 'sugar', capacity: 3, durability: 0, flavor: 0, texture: -3, calories: 2},
  {name: 'sprinkles', capacity: -3, durability: 3, flavor: 0, texture: 0, calories: 9},
  {name: 'candy', capacity: -1, durability: 0, flavor: 4, texture: 0, calories: 1},
  {name: 'chocolate', capacity: 0, durability: 0, flavor: -2, texture: 2, calories: 8},
]

TEST_INGREDIENTS = [
  {name: 'butterscotch', capacity: -1, durability: -2, flavor: 6, texture: 3, calories: 8},
  {name: 'cinnamon', capacity: 2, durability: 3, flavor: -2, texture: -1, calories: 3}
]

def score(quantities, set, target_calories=nil)
  points_by_property = {}
  calories = []
  quantities.each_pair do |ingredient_name, amount|
    properties = set.detect{|a|a[:name] == ingredient_name}
    properties.each_pair do |property, score|
      if property == :calories
        calories << amount * score
        next
      end
      next if property == :name
      points_by_property[property] ||= []
      points_by_property[property] << amount * score
    end
  end

  if target_calories
    total_calories = calories.reduce(:+)
    return 0 unless total_calories == target_calories
  end

  points_by_property.values.collect{|a|a.reduce(:+)}.collect{|a|[a, 0].max}.reduce(:*)
end

raise unless score({'butterscotch' => 44, 'cinnamon' => 56}, TEST_INGREDIENTS) == 62842880

def generate_quantities_4(max)
  all_possibilities = []
  (0..max).each do |i|
    (0..(max-i)).each do |j|
      (0..(max-(i+j))).each do |k|
        (0..(max-(i+j+k))).each do |l|
          all_possibilities << [i,j,k,l]
        end
      end
    end
  end
  return all_possibilities
end

def generate_quantities_2(max)
  all_possibilities = []
  (0..max).each do |i|
    (0..(max-i)).each do |j|
      all_possibilities << [i,j]
    end
  end
  return all_possibilities
end

def search(set, calories=nil)
  highest_score = 0
  winning_recipe = nil
  meth = set.size == 2 ? :generate_quantities_2 : :generate_quantities_4
  method(meth).call(100).each do |possibility|
    recipe = {}
    set.each_with_index do |ingredient, i|
      recipe[ingredient[:name]] = possibility[i]
    end
    current_score = score(recipe, set, calories)
    if current_score > highest_score
      highest_score = current_score
      winning_recipe = recipe
      puts "NEW LEADER: #{winning_recipe.inspect} = #{highest_score}"
    end
  end
  puts "#{winning_recipe.inspect} = #{highest_score}"
end

# puts "test set"
# search(TEST_INGREDIENTS)

# puts "full set"
# search(INGREDIENTS)

puts "test set"
search(TEST_INGREDIENTS, 500)

puts "full set"
search(INGREDIENTS, 500)
