
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
    (position[1] >= 0 ? "West" : "East")
end

def walk(directions, debug=false)
  heading = 0 # North
  position = [0,0] # x (horizontal), y (vertical)

  directions.each do |direction|
    turn  = direction[0]
    steps = direction[1..-1].to_i
    heading = change_heading(heading, turn)

    case heading
    when 0
      position[0] += steps # Go north
    when 1
      position[1] += steps # Go west
    when 2
      position[0] -= steps # Go south
    when 3
      position[1] -= steps # Go east
    end

    puts describe(position) if debug
  end

  position
end

directions = ["R5", "L5", "R5", "R3"]
position = walk(directions, true)
describe(position)

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
position = walk(directions)
describe(position)

# 273