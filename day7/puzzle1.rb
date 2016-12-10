class Array
  def odd_values
    values_at(* each_index.select(&:odd?))
  end
  def even_values
    values_at(* each_index.select(&:even?))
  end
end

def contains_palendrome?(string)
  # Must be four chars which are a palendrome.

  previous = nil
  # Look at each char, and remember the last one.
  string.each_char.with_index do |char, i|
    next_char = string[i+1]
    next_next_char = string[i+2]

    break unless next_char && next_next_char

    # If this is the same as the next char, we have a palendrome candidate.
    if char == next_char
      # The next next char must be the same as `previous`.
      if previous == next_next_char
        # But they musn't all be the same char
        if previous != char
          return true
        end
      end
    end

    previous = char
  end

  false
end

def supports_tls?(string)
  parts = string.split(/\[|\]/)
  abbas = parts.even_values
  hypernets = parts.odd_values
  # Hypernets musn't contain abba
  return false if hypernets.any? {|hs| contains_palendrome?(hs) }
  # Abba must exist in the rest of the string
  abbas.any? { |abba| contains_palendrome?(abba) }
end

# Test
# require 'json'
# example = JSON.parse(File.read("day7/test.json"))
# example.each do |string, expected|
#   result = supports_tls?(string)
#   if result == expected
#     print "."
#   else
#     print "F"
#     puts "#{string} was #{result}, expected #{expected}"
#   end
# end

support_tls = 0
File.open("day7/input.txt").each do |line|
  if supports_tls?(line)
    support_tls += 1
    print "."
  else
    print "F"
  end
end
puts support_tls

# 82 is too low. Didn't realise there were multiple ABBAs and Hypernet sequences
# 115 is the right answer