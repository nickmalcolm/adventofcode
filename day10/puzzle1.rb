# Each bot has two microchip slots
BOTS = Hash.new {|hsh, key| hsh[key] = Array.new }
OUTPUTS = Hash.new {|hsh, key| hsh[key] = Array.new }

# Each bot only proceeds when it has two microchips
# Returns true if proceeded, otherwise false
def give(instruction, target)
  #                       $1          $2            $3           $4        $5            $6           $7
  instruction.match(/bot (\d+) gives (low|high) to (bot|output) (\d+) and (low|high) to (bot|output) (\d+)/)
  bot = BOTS[$1]

  return false unless bot.length == 2

  gift = if $2 == "low"
    bot.delete bot.min
  else
    bot.delete bot.max
  end

  if $3 == "bot"
    BOTS[$4] << gift
  else
    OUTPUTS[$4] << gift
  end

  # This puzzle wants us to find who looks at these two values
  if BOTS[$4].sort.eql? target
    puts "BOT #{$4} is responsible!"
  end

  gift = if $5 == "low"
    bot.delete bot.min
  else
    bot.delete bot.max
  end

  if gift == nil
    raise "gift is nil"
  end

  if $6 == "bot"
    BOTS[$7] << gift
  else
    OUTPUTS[$7] << gift
  end

  # This puzzle wants us to find who looks at these two values
  if BOTS[$7].sort.eql? target
    puts "BOT #{$7} is responsible!"
  end

  true
end

def perform(instructions, target)
  # Go through the instructions until we've processed all of them
  while instructions.length > 0
    instructions.each do |instruction|
      if instruction.start_with?("value")
        instruction.match(/\D*(\d+) \D*(\d+)\D*/)
        value  = $1.to_i
        bot_id = $2
        BOTS[bot_id] << value
        instructions.delete instruction
      else
        if give(instruction, target)
          instructions.delete instruction
        else
          # This bot doesn't have two yet
        end
      end
    end
  end

end



# example = [
#   "value 5 goes to bot 2",
#   "bot 2 gives low to bot 1 and high to bot 0",
#   "value 3 goes to bot 1",
#   "bot 1 gives low to output 1 and high to bot 0",
#   "bot 0 gives low to output 2 and high to output 0",
#   "value 2 goes to bot 2"
# ]
#
# perform(example, [2, 5])

instructions = File.readlines("day10/input.txt")
perform(instructions, [17,61])

# puts "BOTS"
# puts BOTS
# puts "OUTPUTS"
puts OUTPUTS

# 118 is the right answer

53*73*37
# 143153 is the right answer