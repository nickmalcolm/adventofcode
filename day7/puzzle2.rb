class Array
  def odd_values
    values_at(* each_index.select(&:odd?))
  end
  def even_values
    values_at(* each_index.select(&:even?))
  end
end

def palendromes(string)
  palendromes = []

  previous = nil
  # Look at each char, and remember the last one.
  string.each_char.with_index do |char, i|
    next_char = string[i+1]

    break unless next_char

    # If previous and next are the same, and it's not three of the same,
    # we have a winner
    if previous == next_char && previous != char
      palendromes << "#{previous}#{char}#{next_char}"
    end

    previous = char
  end

  palendromes
end

# ABA -> BAB
def opposite_palendrome(palendrome)
  palendrome[1] + palendrome[0] + palendrome[1]
end

def contains_matching_palendrome?(string, valid_palendromes)
  # Get the palendromes from this string
  candidates = palendromes(string)
  # If any of those palendroms match our valid list, then we're good.
  (valid_palendromes & candidates).any?
end

def supports_ssl?(string)
  parts = string.split(/\[|\]/)
  abbas = parts.even_values
  hypernets = parts.odd_values

  hs_palendromes = hypernets.each.collect {|hs| palendromes(hs)}.flatten
  return false unless hs_palendromes.any?

  # ABA palendrome must exist, and match a BAB planedrome from hs
  valid_palendromes = hs_palendromes.collect {|p| opposite_palendrome(p) }
  abbas.any? { |abba| contains_matching_palendrome?(abba, valid_palendromes) }
end

# Test
# require 'json'
# example = JSON.parse(File.read("day7/test2.json"))
# example.each do |string, expected|
#   result = supports_ssl?(string)
#   if result == expected
#     print "."
#   else
#     print "F"
#     puts "#{string} was #{result}, expected #{expected}"
#   end
# end

support_ssl = 0
File.open("day7/input.txt").each do |line|
  if supports_ssl?(line)
    support_ssl += 1
    print "."
  else
    print "F"
  end
end
puts support_ssl


# 231 is the right answer