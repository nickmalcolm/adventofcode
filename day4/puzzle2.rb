
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
  name.gsub("-","").each_char do |char|
    letter_counts[char] += 1
  end
  sorted_letter_counts = letter_counts.to_a.sort {|a, b| compare(a, b) }
  expected = sorted_letter_counts.first(5).map {|a| a[0]}
  expected.join.eql? checksum
end

def decrypt_name(name, sector)
  offset = "a".ord # 97 (the ascii value of 'a')
  mod = 26

  name.each_char.collect do |char|
    if char.eql?("-")
      " "
    else
      # Shift the character back to "alphabet position",
      # increment it by (sector % 26) number of times to avoid extra work,
      # and mod that again to wrap around the alphabet
      # then shift it back into the ascii space, and get the char value
      ((((char.ord - offset) + sector % 26) % 26) + offset).chr
    end
  end.join
end

# decrypt_name("qzmt-zixmtkozy-ivhz", 343)

File.open("day4/input.txt").each do |line|
  encrypted_name, sector, checksum = line.match(/(.*)-(\d+)\[(.*)\]/).to_a.last(3)
  if checksum_valid?(encrypted_name, checksum)
    name = decrypt_name(encrypted_name, sector.to_i)
    if name.include?("pole")
      puts "#{name}: #{sector}"
    end
  end
end

# northpole object storage: 993
