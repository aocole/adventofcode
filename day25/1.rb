value = 20151125
row = 1
column = 1
last_row = 1
last_column = 1

target_row = 2947
target_column = 3029

while true

  # figure out next position
  if row == 1
    last_row += 1
    row = last_row
    column = 1
  else
    row -= 1
    column += 1
  end

  value = (value * 252533) % 33554393

  if row == target_row && column == target_column
    puts value
    break
  end
end