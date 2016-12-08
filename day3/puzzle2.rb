
def valid_triangle?(sides)
  sides.permutation(3).all? do |perm|
    perm[0] + perm[1] > perm[2]
  end
end

# Takes three lines representing three columns and three rows, and returns
# sets of 3 values from columns
def sets_of_sides_from_lines(lines)
  col1 = []
  col2 = []
  col3 = []
  lines.each_with_index do |line, i|
    values = line.split(" ").map(&:to_i)
    col1[i] = values[0]
    col2[i] = values[1]
    col3[i] = values[2]
  end

  return col1, col2, col3
end

valid_count = 0
File.readlines("day3/puzzle1_input.txt").each_slice(3) do |lines|
  sets_of_sides = sets_of_sides_from_lines(lines)
  sets_of_sides.each {|s| valid_count += 1 if valid_triangle?(s)}
end

puts valid_count

# 1838 was right.