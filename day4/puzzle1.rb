
# Compares two arrays where the first value is a char, and the second value is
# an int, for use with Enumerable#sort
# If the ints are the same, it's alphabetical.
# Otherwise it compares the chars.
def compare(arr1, arr2)
  if arr1[1] == arr2[1]
    arr1[0].ord - arr2[0].ord
  else
    arr2[1] - arr1[1]
  end
end

def checksum_valid?(name, checksum)
  # First, get the list of characters in the name sorted by most frequent,
  # breaking ties with alphabetical.
  letter_counts = Hash.new(0)
  name.each_char do |char|
    letter_counts[char] += 1
  end
  sorted_letter_counts = letter_counts.to_a.sort {|a, b| compare(a, b) }
  expected = sorted_letter_counts.first(5).map {|a| a[0]}
  expected.join.eql? checksum
end

def sum_of_valid_sectors(lines)
  sector_sum = 0
  lines.each do |line|
    encrypted_name, sector, checksum = line.match(/(.*)-(\d+)\[(.*)\]/).to_a.last(3)
    if checksum_valid?(encrypted_name.gsub("-",""), checksum)
      sector_sum += sector.to_i
    end
  end
  sector_sum
end


# example = [
#   "aaaaa-bbb-z-y-x-123[abxyz]",
#   "a-b-c-d-e-f-g-h-987[abcde]",
#   "not-a-real-room-404[oarel]",
#   "totally-real-room-200[decoy]"
# ]
# puts sum_of_valid_sectors(example)

sector_sum = 0
File.open("day4/input.txt").each do |line|
  encrypted_name, sector, checksum = line.match(/(.*)-(\d+)\[(.*)\]/).to_a.last(3)
  if checksum_valid?(encrypted_name.gsub("-",""), checksum)
    sector_sum += sector.to_i
  end
end
puts sector_sum

# 158835 is right