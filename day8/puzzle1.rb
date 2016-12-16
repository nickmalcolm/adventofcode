def draw(canvas)
  print "\n"
  print canvas.map(&:join).join("\n")
  print "\n"
end

# turns on all of the pixels in a rectangle at the top-left of the
# screen which is A wide and B tall.
def rect(canvas, width, height)
  height.times do |y|
    width.times do |x|
      canvas[y][x] = "#"
    end
  end
end

# Shifts all of the pixels in `row` right by `shift` pixels.
# Pixels that would fall off the right end appear at the left end of the row.
def rotate_row(canvas, row, shift)
  # Pop the value of the end, and move it to the front.
  shift.times { canvas[row].unshift(canvas[row].pop) }
end

# Shifts all of the pixels in col down by shift pixels.
# Pixels that would fall off the bottom appear at the top of the column
def rotate_col(canvas, col, shift)
  # Get the values for this column
  vals = canvas.collect {|row| row[col] }
  # Pop the value of the end, and move it to the front.
  shift.times { vals.unshift(vals.pop) }
  # Put the result back in the canvas
  canvas.each {|row| row[col] = vals.shift }
end

def process_instruction(canvas, instruction)
  instruction.match(/(\d+)\D*(\d+)/)
  a = $1.to_i
  b = $2.to_i
  if instruction.start_with?("rect")
    rect(canvas, a, b)
  elsif instruction.start_with?("rotate row")
    rotate_row(canvas, a, b)
  elsif instruction.start_with?("rotate col")
    rotate_col(canvas, a, b)
  end
  canvas
end

# Test
# canvas = Array.new(3) { Array.new(7, ".") }
# instructions = [
#   "rect 6x2"
# ]
# instructions.each do |instruction|
#   canvas = process_instruction(canvas, instruction)
# end


canvas = Array.new(6) { Array.new(50, ".") }
i = 0
File.open("day8/input.txt").each do |instruction|
  canvas = process_instruction(canvas, instruction)
end

draw(canvas)
puts canvas.flatten.select {|p| p.eql?("#") }.count

# 83 is too low. Had a bug in my matcher which ignored integers
#  in the second argument: /(\d+).*(\d+)/ instead of /(\d+)\D*(\d+)/
#  Would read "12 x 45" as 12 and 5
# 106 is the right answer

#    .##..####.#....####.#.....##..#...#####..##...###.
#    #..#.#....#....#....#....#..#.#...##....#..#.#....
#    #....###..#....###..#....#..#..#.#.###..#....#....
#    #....#....#....#....#....#..#...#..#....#.....##..
#    #..#.#....#....#....#....#..#...#..#....#..#....#.
#    .##..#....####.####.####..##....#..#.....##..###..