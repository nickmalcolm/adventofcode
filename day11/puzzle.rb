FLOOR_ENUM = {
  0 => "PG".freeze,
  1 => "PM".freeze,
  2 => "TG".freeze,
  3 => "TM".freeze,
  4 => "MG".freeze,
  5 => "MM".freeze,
  6 => "RG".freeze,
  7 => "RM".freeze,
  8 => "CG".freeze,
  9 => "CM".freeze,
}

class Floor

  attr_accessor :items
  def initialize
    @items = Array.new(10)
  end

  def valid?
    compact = @items.compact
    compact.each do |item|
      if item.odd? # It's a microchip
        # It needs its generator
        unless compact.include?(item-1)
          # If it doesn't have its generator, there must be no other generators
          # on the floor
          if compact.any?(&:even?)
            return false
          end
        end
      end
    end
    true
  end

  def can_have?(new_items)
    f = Floor.new
    f.items = @items.dup
    new_items.each do |item|
      f.items[item] = item
    end
    f.valid?
  end

  def to_s
    s = ""
    @items.each do |item|
      if item
        s += "#{FLOOR_ENUM[item]} "
      else
        s += " . "
      end
    end
    s
  end

  def dup
    f = Floor.new
    f.items = items.dup
    f
  end

end

class Building
  attr_accessor :floors
  attr_accessor :current_floor

  def initialize
    @floors = [
      Floor.new, # F0
      Floor.new, # F1
      Floor.new, # F2
      Floor.new  # F3
    ]
    @current_floor = 0
  end

  # Returns the possible floors after this floor
  def valid_moves
    moves = []
    # If the floor is on the bottom or top floor, it can only go One Direction
    if @current_floor == 0
      # Has to go up
      # We can take up just this item
      @floors[@current_floor].items.compact.each do |item|
        new_building = self.dup
        destination_floor = new_building.floors[@current_floor+1]

        if destination_floor.can_have?([item])
          # Valid move
          new_building.floors[@current_floor].items[item] = nil
          new_building.floors[@current_floor+1].items[item] = item
          moves << new_building
        end
      end

      # Or we can take two items
      @floors[@current_floor].items.compact.permutation(2).each do |items|
        new_building = self.dup
        destination_floor = new_building.floors[@current_floor+1]

        if destination_floor.can_have?(items)
          # Valid move
          items.each do |item|
            new_building.floors[@current_floor].items[item] = nil
            new_building.floors[@current_floor+1].items[item] = item
          end
          moves << new_building
        end
      end
    elsif @current_floor == 3
      # Has to go down
    else
      # Can go up or down
    end

    moves
  end

  def valid?
    @floors.all?(&:valid?)
  end

  def to_s
    s = ""
    (0..3).to_a.reverse.each do |i|

      s += "F#{i+1}"

      if i == @current_floor
        s += " E "
      else
        s += " . "
      end

      s += @floors[i].to_s
      s += "\n"

    end
    s
  end

  def dup
    b = Building.new
    b.floors = self.floors.collect(&:dup)
    b
  end

end

def print_side_by_side(building1, building2)
  (0..3).to_a.reverse.each do |i|

    print "F#{i+1}"

    if i == @current_floor
      print " E "
    else
      print " . "
    end

    print building1.floors[i].to_s
    print "    "
    print building2.floors[i].to_s
    print "\n"
  end
end

# building = Building.new
# building.floors[0].items = [0, nil, 2, 3, 4, nil, 6, 7, 8, 9]
# building.floors[1].items[1] = 1
# building.floors[1].items[5] = 5

# puts building

# puts "Valid next moves: "
# building.valid_moves.each do |move|
#   print_side_by_side(building, move)
#   puts "\n"
# end

building = Building.new
building.floors[0].items = [nil, 1, nil, 3]
building.floors[1].items = [nil, 1, nil, 3]

