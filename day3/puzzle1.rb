
def valid_triangle?(sides)
  sides.permutation(3).all? do |perm|
    perm[0] + perm[1] > perm[2]
  end
end

valid_count = 0
File.open("day3/puzzle1_input.txt").each_line do |line|
  sides = line.split(" ").map(&:to_i)
  valid_count += 1 if valid_triangle?(sides)
end

puts valid_count

# 1034 was wrong. (max <= sum of other two smaller sides)
# 1032 was right. Used array permutations.