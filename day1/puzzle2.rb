
# Heading
#   0 North, 1 East, 2 South, 3 West
def change_heading(from, turn)
  if "L".eql? turn
    from = (from-1)%4
  else
    from = (from+1)%4
  end
end

def describe(position)
  "#{position[0].abs} blocks " +
    (position[0] >= 0 ? "North" : "South") +
    " and " +
  "#{position[1].abs} blocks " +
    (position[1] >= 0 ? "East" : "West")
end

def remember(history, position)
  puts describe(position)
  if history.include?(position)
    raise ArgumentError, "You've been here before: #{describe position}"
  else
    history << position.dup
  end
end

def walk_with_memory(directions)
  heading = 0 # North
  position = [0,0] # x (horizontal), y (vertical)

  # In puzzle 2 we want to stop when we recross our path
  history = []

  directions.each do |direction|

    turn  = direction[0]
    steps = direction[1..-1].to_i
    heading = change_heading(heading, turn)

    operand, operator = case heading
    when 0
      steps.times do
        position[0] += 1 # Go north
        remember(history, position)
      end
    when 1
      steps.times do
        position[1] += 1 # Go east
        remember(history, position)
      end
    when 2
      steps.times do
        position[0] -= 1 # Go south
        remember(history, position)
      end
    when 3
      steps.times do
        position[1] -= 1 # Go west
        remember(history, position)
      end
    end
  end

  position
end

directions = ["L5", "R1", "R3", "L4", "R3", "R1", "L3", "L2", "R3", "L5", "L1",
"L2", "R5", "L1", "R5", "R1", "L4", "R1", "R3", "L4", "L1", "R2", "R5", "R3",
"R1", "R1", "L1", "R1", "L1", "L2", "L1", "R2", "L5", "L188", "L4", "R1", "R4",
"L3", "R47", "R1", "L1", "R77", "R5", "L2", "R1", "L2", "R4", "L5", "L1", "R3",
"R187", "L4", "L3", "L3", "R2", "L3", "L5", "L4", "L4", "R1", "R5", "L4", "L3",
"L3", "L3", "L2", "L5", "R1", "L2", "R5", "L3", "L4", "R4", "L5", "R3", "R4",
"L2", "L1", "L4", "R1", "L3", "R1", "R3", "L2", "R1", "R4", "R5", "L3", "R5",
"R3", "L3", "R4", "L2", "L5", "L1", "L1", "R3", "R1", "L4", "R3", "R3", "L2",
"R5", "R4", "R1", "R3", "L4", "R3", "R3", "L2", "L4", "L5", "R1", "L4", "L5",
"R4", "L2", "L1", "L3", "L3", "L5", "R3", "L4", "L3", "R5", "R4", "R2", "L4",
"R2", "R3", "L3", "R4", "L1", "L3", "R2", "R1", "R5", "L4", "L5", "L5", "R4",
"L5", "L2", "L4", "R4", "R4", "R1", "L3", "L2", "L4", "R3"]
position = walk_with_memory(directions)

# First guess: 257 ([111, -146])
#   Reason: I thought it was first revist of distinct direction destinations,
#     when it's actually wanting the first time you cross your path
# Second guess: 115 ([113, 2]) Correct

example = ["R8", "R4", "R4", "R8"]
position = walk_with_memory(example)
